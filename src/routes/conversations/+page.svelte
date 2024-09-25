<script>
  import { getContext, onMount } from "svelte";
  import MessageItem from "$src/components/messages/MessageItem.svelte";
  import MessageHeader from "$src/components/messages/MessageHeader.svelte";
  import { goto } from "$app/navigation";
  import { derived } from "svelte/store";

  const storedConversations = getContext("storedConversations");

  // Function to sort conversations by latest message
  function sortConversations(convs) {
    return [...convs].sort((a, b) => {
      const aLastMessage = a.messages[a.messages.length - 1];
      const bLastMessage = b.messages[b.messages.length - 1];
      if (!aLastMessage) return 1;
      if (!bLastMessage) return -1;
      return (
        new Date(bLastMessage.timestamp) - new Date(aLastMessage.timestamp)
      );
    });
  }

  // Create a derived store for active conversations
  const activeConversations = derived(
    storedConversations,
    ($storedConversations) =>
      sortConversations(
        $storedConversations.filter((conv) => conv.messages.length > 0),
      ),
  );

  // Function to open a conversation by navigating to its route
  function openConversation(id) {
    goto(`/conversation/${id}`);
  }

  // Force component update when mounted
  onMount(() => {
    storedConversations.update((convs) => [...convs]);
  });
</script>

<main class="conversations-page">
  <MessageHeader class="message-header" />

  <div class="conversation-list">
    {#each $activeConversations as conversation (conversation.id)}
      <div
        on:click={() => openConversation(conversation.id)}
        on:keydown={(e) =>
          e.key === "Enter" && openConversation(conversation.id)}
        tabindex="0"
        role="button"
      >
        <MessageItem conversationId={conversation.id} />
      </div>
    {/each}
  </div>
</main>

<style>
  .conversations-page {
    display: flex;
    flex-direction: column;
    height: 100vh;
    overflow: hidden;
  }

  .conversation-list {
    flex-grow: 1;
    overflow-y: auto;
    padding: 0 10px;
  }

  .conversation-list > div {
    cursor: pointer;
  }
  :global(.message-header) {
    position: sticky;
    top: 0;
    z-index: 1; /* Ensure it stays above other content */
    background-color: white; /* Set a background color to avoid overlap issues */
  }
</style>
