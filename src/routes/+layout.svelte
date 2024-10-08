<script>
  import Loader from "../components/Loader.svelte";
  import { onMount, setContext, getContext } from "svelte";
  import Navigations from "../components/Navigations.svelte";
  import { conversations } from "../lib/messageScript.js";
  import { writable } from "svelte/store";
  import { comments } from "../lib/commentScript.js";
  import { feedCharacters } from "../lib/feedCharacters.js";
  import { page } from "$app/stores";

  let loading = true;
  const storedConversations = writable([]);
  const storedPosts = writable([]);
  setContext("storedConversations", storedConversations);
  setContext("storedPosts", storedPosts);

  // Define selectedDay as a writable store
  let selectedDay = writable("weds"); // Default selected day
  setContext("selectedDay", selectedDay);

  let messageInterval;

  let currentConversationId = null;

  $: {
    const match = $page.url.pathname.match(/^\/conversation\/(.+)$/);
    currentConversationId = match ? match[1] : null;
  }

  function handleDayChange(event) {
    $selectedDay = event.target.value;  // Use $ to update the store value
    clearInterval(messageInterval);
    startSendingMessages();
  }

  onMount(() => {
    setTimeout(() => {
      loading = false;
    }, 1000);

    // Initialize storedConversations
    let loadedConversations =
      JSON.parse(localStorage.getItem("conversations")) || [];
    if (loadedConversations.length === 0) {
      loadedConversations = conversations.map((conv) => ({
        id: conv.id,
        character: conv.character,
        messages: [],
        waitingForReply: false, // Initialize the flag
      }));
    } else {
      // Ensure all conversations from messageScript.js are present
      conversations.forEach((conv) => {
        if (!loadedConversations.find((c) => c.id === conv.id)) {
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

    // Initialize storedPosts
    let loadedPosts = JSON.parse(localStorage.getItem("posts")) || [];
    if (loadedPosts.length === 0) {
      // Create 4 initial posts
      for (let i = 0; i < 4; i++) {
        loadedPosts.push(createRandomPost());
      }
    }
    storedPosts.set(loadedPosts);

    // Subscribe to changes in storedConversations and update localStorage
    storedConversations.subscribe((convs) => {
      localStorage.setItem("conversations", JSON.stringify(convs));
    });

    storedPosts.subscribe((posts) => {
      localStorage.setItem("posts", JSON.stringify(posts));
    });

    // Start sending messages for the selected day
    startSendingMessages();

    // Start creating random posts every 10 seconds
    setInterval(createAndStoreRandomPost, 10000);
  });

  function startSendingMessages() {
    clearInterval(messageInterval);
    messageInterval = setInterval(() => {
      const dayMessages = getDayMessages($selectedDay).filter((conv) => {
        // Only send messages if not waiting for reply
        const storedConv = $storedConversations.find((sc) => sc.id === conv.id);
        return storedConv && !storedConv.waitingForReply;
      });
      if (dayMessages.length > 0) {
        dayMessages.forEach((conversation) => {
          sendNextMessage(conversation.id, conversation.messages);
        });
      }
    }, getRandomDelay());
  }

  function getDayMessages(day) {
    return conversations
      .filter((conv) => conv.messages.some((msg) => msg.day === day))
      .map((conv) => ({
        id: conv.id,
        messages: conv.messages.find((msg) => msg.day === day).messages,
      }));
  }

  function sendNextMessage(conversationId, messages) {
    storedConversations.update((convs) => {
      let updatedConvs = [...convs];
      let conversation = updatedConvs.find((c) => c.id === conversationId);
      if (!conversation) {
        const originalConv = conversations.find((c) => c.id === conversationId);
        conversation = {
          id: conversationId,
          character: originalConv.character,
          messages: [],
          waitingForReply: false,
        };
        updatedConvs.push(conversation);
      }

      if (conversation.waitingForReply) {
        // Do not send the next message until the user responds appropriately
        return updatedConvs;
      }

      // Get all character messages for the selected day
      // Inside sendNextMessage function
      const characterMessagesForDay = conversation.messages.filter(
        (msg) =>
          msg.day === $selectedDay && msg.day !== "You" && !msg.isFeedback, // Exclude feedback messages
      );

      const messagesSentForDay = characterMessagesForDay.length;
      const nextMessageIndex = messagesSentForDay;

      // Get the previous character message
      const previousMessage =
        characterMessagesForDay[characterMessagesForDay.length - 1];

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

          // Handle different reply types
          if (nextMessage.reply === "none") {
            // No reply needed, proceed to next message after delay
            conversation.waitingForReply = false;
          } else if (nextMessage.reply === "any") {
            // Wait for any reply from user
            conversation.waitingForReply = true;
            conversation.expectedReplyType = "any";
          } else if (Array.isArray(nextMessage.reply)) {
            // Wait for specific keyword reply
            conversation.waitingForReply = true;
            conversation.expectedReplyType = "keyword";
            conversation.expectedKeywords = nextMessage.reply.map((k) =>
              k.toLowerCase(),
            );
          }
        }
      }

      return updatedConvs;
    });
  }
  function getRandomDelay() {
    return (Math.floor(Math.random() * 7) + 3) * 1000; // 1-5 seconds
  }

  function createRandomPost() {
    const randomCharacter =
      feedCharacters[Math.floor(Math.random() * feedCharacters.length)];
    const likedByCharacter =
      feedCharacters[Math.floor(Math.random() * feedCharacters.length)];
    return {
      profilePic: randomCharacter.profilePic,
      username: randomCharacter.username,
      postImage:
        randomCharacter.postImages[
          Math.floor(Math.random() * randomCharacter.postImages.length)
        ],
      likedBy: likedByCharacter.username,
      caption: comments[Math.floor(Math.random() * comments.length)],
      commentCount: Math.floor(Math.random() * 200) + 1,
    };
  }

  function createAndStoreRandomPost() {
    storedPosts.update((posts) => {
      const newPost = createRandomPost();
      return [newPost, ...posts];
    });
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
