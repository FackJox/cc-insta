<script>
    import { getContext, onMount } from 'svelte';
    import { conversations } from '$lib/messagescript.js';
  
    export let conversationId;
  
    const storedConversations = getContext('storedConversations');
  
    $: conversation = $storedConversations.find(c => c.id === conversationId) || { messages: [] };
    $: lastMessage = conversation.messages.length > 0 
      ? conversation.messages[conversation.messages.length - 1].text 
      : 'No messages yet';
  
    // Fetch the conversation character info from messagescript.js
    $: characterInfo = conversations.find(c => c.id === conversationId)?.character || {};
  
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
  
  <div class="message-item">
    <div class="avatar">
      <img src={characterInfo.image} alt={characterInfo.name} width="50" height="50" />
    </div>
    <div class="info">
      <label>{characterInfo.name}</label><br />
      <span>{lastMessage}</span>
    </div>
  </div>
  
  <style>
    .message-item {
      display: flex;
      align-items: center;
      padding: 10px;
      border-bottom: 1px solid #e0e0e0;
    }
  
    .avatar {
      margin-right: 10px;
    }
  
    .avatar img {
      border-radius: 50%;
      object-fit: cover;
    }
  
    .info {
      flex-grow: 1;
    }
  
    .info label {
      font-weight: bold;
      margin-bottom: 2px;
    }
  
    .info span {
      color: #666;
      font-size: 0.9em;
    }
  </style>