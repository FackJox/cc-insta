<!-- MessageList.svelte -->
<script>
  import MessageItem from './MessageItem.svelte';

  const messages = [
    { image: 'assets/aditya.jpg', name: 'Aditya Ekhande', text: 'Reacted 💖 to your message. 3m' },
    { image: 'assets/akash.webp', name: 'Akash Sahane', text: 'Reacted 😂 to your message. 10m' },
    // ... other messages ...
  ];
</script>

{#each messages as msg}
  <MessageItem {msg} />
{/each}

<style>
  /* message-list styles */
</style>