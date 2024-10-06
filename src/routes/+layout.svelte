<script>
  import Loader from "../components/Loader.svelte";
  import { onMount, setContext, getContext } from "svelte";
  import Navigations from "../components/Navigations.svelte";
  import { conversations } from "../lib/messageScript.js";
  import { writable } from 'svelte/store';
  import { comments } from "../lib/commentScript.js";
  import { feedCharacters } from "../lib/feedCharacters.js";
  import { page } from '$app/stores';

  let loading = true;
  const storedConversations = writable([]);
  setContext('storedConversations', storedConversations);

  // Define selectedDay as a writable store
  let selectedDay = writable('weds'); // Default selected day
  setContext('selectedDay', selectedDay);

  let messageInterval;

  let currentConversationId = null;

  $: {
    const match = $page.url.pathname.match(/^\/conversation\/(.+)$/);
    currentConversationId = match ? match[1] : null;
  }

  function handleDayChange(event) {
    selectedDay = event.target.value;
    clearInterval(messageInterval);
    startSendingMessages();
}

  let messageTimeout;

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
        messages: [],
        waitingForReply: false, // Initialize the flag
      }));
    } else {
      // Ensure all conversations from messageScript.js are present
      conversations.forEach(conv => {
        if (!loadedConversations.find(c => c.id === conv.id)) {
          loadedConversations.push({
            id: conv.id,
            character: conv.character,
            messages: [],
            waitingForReply: false, // Initialize the flag
          });
        }
      });
    }
    storedConversations.set(loadedConversations);


    // Subscribe to changes in storedConversations and update localStorage
    storedConversations.subscribe(convs => {
      localStorage.setItem('conversations', JSON.stringify(convs));
    });

    // Start sending messages for the selected day
    startSendingMessages();
  });

  function startSendingMessages() {
    clearInterval(messageInterval);
    messageInterval = setInterval(() => {
      const dayMessages = getDayMessages($selectedDay).filter(conv => {
        // Only send messages if not waiting for reply
        const storedConv = $storedConversations.find(sc => sc.id === conv.id);
        return storedConv && !storedConv.waitingForReply;
      });
      if (dayMessages.length > 0) {
        dayMessages.forEach(conversation => {
          sendNextMessage(conversation.id, conversation.messages);
        });
      }
    }, getRandomDelay());
  }

  function getDayMessages(day) {
    return conversations.filter(conv =>
      conv.messages.some(msg => msg.day === day)
    ).map(conv => ({
      id: conv.id,
      messages: conv.messages.find(msg => msg.day === day).messages
    }));
  }

  function sendNextMessage(conversationId, messages) {
    storedConversations.update(convs => {
      let updatedConvs = [...convs];
      let conversation = updatedConvs.find(c => c.id === conversationId);
      if (!conversation) {
        const originalConv = conversations.find(c => c.id === conversationId);
        conversation = { id: conversationId, character: originalConv.character, messages: [], waitingForReply: false };
        updatedConvs.push(conversation);
      }

      if (conversation.waitingForReply) {
        // Do not send the next message until the user responds correctly
        return updatedConvs;
      }

      // Determine the number of messages sent for the selected day
      const messagesSentForDay = conversation.messages.filter(msg => msg.day === $selectedDay).length;
      const nextMessageIndex = messagesSentForDay;
      const previousMessage = conversation.messages[nextMessageIndex - 1];

      if (nextMessageIndex < messages.length) {
        if (!previousMessage || previousMessage.read) {
          const nextMessage = messages[nextMessageIndex];
          const message = {
            text: nextMessage.text,
            timestamp: new Date().toISOString(),
            day: $selectedDay,
            read: false,
            reply: nextMessage.reply || null, // Include reply field
          };
          conversation.messages = [...conversation.messages, message];

          // If the message requires a reply, set waitingForReply to true
          if (Array.isArray(nextMessage.reply)) {
            conversation.waitingForReply = true;
          }
        }
      }

      return updatedConvs;
    });
  }

  function getRandomDelay() {
    return (Math.floor(Math.random() * 5) + 1) * 1000; // 1-5 seconds
  }
</script>


<div class="day-selector">
<select bind:value={$selectedDay} on:change={handleDayChange}>
<option value="weds">Wednesday</option>
<option value="thurs">Thursday</option>
<option value="fri">Friday</option>
<option value="sat">Saturday</option>
</select>
</div>

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
