<script>
  import Loader from "../components/Loader.svelte";
  import { onMount, setContext } from "svelte";
  import Navigations from "../components/Navigations.svelte";
  import { conversations } from "../lib/messagescript.js";
  import { writable } from 'svelte/store';

  let loading = true;
  const storedConversations = writable([]);
  setContext('storedConversations', storedConversations);

  onMount(() => {
    setTimeout(() => {
      loading = false;
    }, 1000);

    // Initialize storedConversations
    let loadedConversations = JSON.parse(localStorage.getItem('conversations')) || [];
    if (loadedConversations.length === 0) {
      loadedConversations = conversations.map(conv => ({
        id: conv.id,
        character: conv.character,
        messages: []
      }));
    } else {
      // Ensure all conversations from messagescript.js are present
      conversations.forEach(conv => {
        if (!loadedConversations.find(c => c.id === conv.id)) {
          loadedConversations.push({
            id: conv.id,
            character: conv.character,
            messages: []
          });
        }
      });
    }
    storedConversations.set(loadedConversations);

    // Subscribe to changes in storedConversations and update localStorage
    storedConversations.subscribe(convs => {
      localStorage.setItem('conversations', JSON.stringify(convs));
    });

    // Start sending random messages every 10 seconds
    setInterval(sendRandomMessage, 10000);
  });

  function sendRandomMessage() {
    const randomConversation = conversations[Math.floor(Math.random() * conversations.length)];
    const randomMessage = randomConversation.messages[0].messages[Math.floor(Math.random() * randomConversation.messages[0].messages.length)];

    sendTimeBasedMessage(randomConversation.id, randomMessage.text);
  }

  function sendTimeBasedMessage(conversationId, messageText) {
    storedConversations.update(convs => {
      let updatedConvs = [...convs];
      let conversation = updatedConvs.find(c => c.id === conversationId);

      if (!conversation) {
        const originalConv = conversations.find(c => c.id === conversationId);
        conversation = { id: conversationId, character: originalConv.character, messages: [] };
        updatedConvs.push(conversation);
      }

      const message = {
        text: messageText,
        timestamp: new Date().toISOString(),
        day: conversation.character.name,
      };
      conversation.messages = [...conversation.messages, message];

      // Send notification
      if ('Notification' in window && Notification.permission === 'granted') {
        new Notification('New Message', { body: messageText });
      }

      return updatedConvs;
    });
  }
</script>
{#if loading}
  <Loader />
{:else}
  <slot />

  <div class="navigations-div">
    <Navigations />
  </div>
{/if}

<style>
  .navigations-div {
    width: 100%;
    height: 40px;
    background-color: rgb(255, 255, 255);
    position: fixed;
    bottom: 0;
    left: 0;
    z-index: 1000;
    padding-bottom: env(safe-area-inset-bottom);
  }
</style>