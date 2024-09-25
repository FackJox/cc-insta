<script>
  import Loader from "../components/Loader.svelte";
  import { onMount, setContext } from "svelte";
  import Navigations from "../components/Navigations.svelte";
  import { conversations } from "../lib/messageScript.js";
  import { writable } from 'svelte/store';
  import { comments } from "../lib/commentScript.js";
  import { feedcharacters } from "../lib/feedCharacters.js";

  let loading = true;
  const storedConversations = writable([]);
  const storedPosts = writable([]);
  setContext('storedConversations', storedConversations);
  setContext('storedPosts', storedPosts);

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
    storedConversations.set(loadedConversations);

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

    // Start sending random messages every 10 seconds
    setInterval(sendRandomMessage, 10000);

    // Start creating random posts every 10 seconds
    setInterval(createAndStoreRandomPost, 10000);
  });

  function sendRandomMessage() {
    // ... (existing code)
  }

  function sendTimeBasedMessage(conversationId, messageText) {
    // ... (existing code)
  }

  function createRandomPost() {
    const randomCharacter = feedcharacters[Math.floor(Math.random() * feedcharacters.length)];
    const likedByCharacter = feedcharacters[Math.floor(Math.random() * feedcharacters.length)];
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