<script>
  import Loader from "../components/Loader.svelte";
  import { onMount, setContext } from "svelte";
  import Navigations from "../components/Navigations.svelte";
  import { conversations } from "../lib/messageScript.js";
  import { writable } from 'svelte/store';
  import { comments } from "../lib/commentScript.js";
  import { feedCharacters } from "../lib/feedCharacters.js";
  import { page } from '$app/stores';

  let loading = true;
  const storedConversations = writable([]);
  const storedPosts = writable([]);
  setContext('storedConversations', storedConversations);
  setContext('storedPosts', storedPosts);

  let selectedDay = 'weds'; // Default selected day
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
    console.log('Loaded Conversations from Local Storage:', loadedConversations); // Debug log
    if (loadedConversations.length === 0) {
      loadedConversations = conversations.map(conv => ({
        id: conv.id,
        character: conv.character,
        messages: []
      }));
    } else {
      // Ensure all conversations from messageScript.js are present
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
    storedConversations.set(loadedConversations)

    // Initialize storedPosts
    let loadedPosts = JSON.parse(localStorage.getItem('posts')) || [];
    if (loadedPosts.length === 0) {

// Create 4 initial posts
for (let i = 0; i < 4; i++) {
  loadedPosts.push(createRandomPost());
}
}
storedPosts.set(loadedPosts);

// Subscribe to changes in storedConversations and update localStorage
storedConversations.subscribe(convs => {
localStorage.setItem('conversations', JSON.stringify(convs));
});

// Subscribe to changes in storedPosts and update localStorage
storedPosts.subscribe(posts => {
localStorage.setItem('posts', JSON.stringify(posts));
});

// Start sending messages for the selected day
startSendingMessages();

// Start creating random posts every 10 seconds
setInterval(createAndStoreRandomPost, 10000);

});

function startSendingMessages() {
    clearInterval(messageInterval);
    messageInterval = setInterval(() => {
      const dayMessages = getDayMessages(selectedDay);
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
            conversation = { id: conversationId, character: originalConv.character, messages: [] };
            updatedConvs.push(conversation);
        }

        // Filter messages for the selected day
        const messagesForSelectedDay = conversation.messages.filter(msg => msg.day === selectedDay);
        const nextMessageIndex = messagesForSelectedDay.length;
        const previousMessage = messagesForSelectedDay[nextMessageIndex - 1];

        // Check if there are more messages to send for the selected day
        if (nextMessageIndex < messages.length) {
            // Send the next message only if it's the first message or the previous message has been read
            if (!previousMessage || previousMessage.read) {
                const message = {
                    text: messages[nextMessageIndex].text,
                    timestamp: new Date().toISOString(),
                    day: selectedDay,
                    read: false, // Mark as unread initially
                };
                conversation.messages = [...conversation.messages, message];
            }
        }

        return updatedConvs;
    });
}




function getRandomDelay() {
return (Math.floor(Math.random() * 5) + 1) * 1000; // 1-5 seconds
}


function createRandomPost() {
const randomCharacter = feedCharacters[Math.floor(Math.random() * feedCharacters.length)];
const likedByCharacter = feedCharacters[Math.floor(Math.random() * feedCharacters.length)];
return {
profilePic: randomCharacter.profilePic,
username: randomCharacter.username,
postImage: randomCharacter.postImages[Math.floor(Math.random() * randomCharacter.postImages.length)],
likedBy: likedByCharacter.username,
caption: comments[Math.floor(Math.random() * comments.length)],
commentCount: Math.floor(Math.random() * 200) + 1
};
}

function createAndStoreRandomPost() {
storedPosts.update(posts => {
const newPost = createRandomPost();
return [newPost, ...posts];
});
}
</script>

<div class="day-selector">
<select bind:value={selectedDay} on:change={handleDayChange}>
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
