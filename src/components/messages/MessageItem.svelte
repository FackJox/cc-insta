<script>
    import { getContext, onMount } from 'svelte';
    import { conversations } from '$lib/messagescript.js';
  
    export let conversationId;
  
    const storedConversations = getContext('storedConversations');
  

    $: truncatedLastMessage = lastMessage.length > 25 
        ? lastMessage.slice(0, 25) + '...' 
        : lastMessage;


    $: conversation = $storedConversations.find(c => c.id === conversationId) || { messages: [] };
    $: lastMessage = conversation.messages.length > 0 
      ? conversation.messages[conversation.messages.length - 1].text 
      : 'No messages yet';
    $: lastMessageTimestamp = conversation.messages.length > 0
      ? new Date(conversation.messages[conversation.messages.length - 1].timestamp)
      : null;
  
    // Fetch the conversation character info from messagescript.js
    $: characterInfo = conversations.find(c => c.id === conversationId)?.character || {};
  
    function formatLastMessaged(timestamp) {
      if (!timestamp) return '';
      
      const now = new Date();
      const diff = now - timestamp;
      const minutes = Math.floor(diff / 60000);
      const hours = Math.floor(diff / 3600000);
      const days = Math.floor(diff / 86400000);

      if (days === 0) {
        if (minutes < 60) return `${minutes}m ago`;
        if (hours < 24) return `${hours}h ago`;
      } else if (days === 1) {
        return 'yesterday';
      } else if (days === 2) {
        return timestamp.toLocaleString('en-US', { weekday: 'short' }).toLowerCase();
      } else {
        return timestamp.toLocaleString('en-US', { weekday: 'short' }).toLowerCase();
      }
    }

    $: lastMessaged = formatLastMessaged(lastMessageTimestamp);

    onMount(() => {
      if (!conversation.character) {
        storedConversations.update(convs => 
          convs.map(conv => 
            conv.id === conversationId 
              ? { ...conv, character: characterInfo }
              : conv
          )
        );
      }
    });
</script>

<div class="row">
    <div class="col">
      <img src={characterInfo.image} alt={characterInfo.name} width="50">
    </div>
    <div class="col message-content">
      <label>{characterInfo.name}</label>
      <div class="message-info">
        <span class="last-message">{truncatedLastMessage}</span>
        <span class="last-messaged">· {lastMessaged}</span>
      </div>
    </div>
    <div class="col">
      <img src="icons/icons8-camera-50.png" alt="" width="25">
    </div>
  </div>

<style>
  .row {
    display: flex;
    flex-direction: row;
    gap: 10px;
    margin-top: 20px;
    position: relative;
  }

  .row .col:nth-child(2) {
    color: rgb(47, 47, 48);
    font-size: 14px;
    padding: 4px 0;
    flex-grow: 1;
  }

  .message-content {
    display: flex;
    flex-direction: column;
  }

  .message-info {
    display: flex;
    align-items: center;
    gap: 5px;
  }

  .last-message {
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
  }

  .last-messaged {
    font-size: 12px;
    color: #888;
    white-space: nowrap;
  }

  .row .col:nth-child(3) {
    position: absolute;
    right: 5px;
    top: 15px;
  }

  .row .col:nth-child(1) img {
    border-radius: 50%;
  }
</style>