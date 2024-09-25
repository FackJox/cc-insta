<script>
    import { onMount, getContext } from 'svelte';
    import { page } from '$app/stores';
    import { goto } from '$app/navigation';
    import { writable } from 'svelte/store';
    import { conversations } from '$lib/messagescript.js';
  
    let conversationId;
    let conversationStore = writable(null);
    let newMessage = '';
    const storedConversations = getContext('storedConversations');
  
    // Get the conversation ID from the URL parameter
    $: conversationId = $page.params.id;
  
    onMount(() => {
      // Load conversations from storedConversations context
      const unsubscribe = storedConversations.subscribe(convs => {
        let foundConversation = convs.find(c => c.id === conversationId);
  
        if (!foundConversation) {
          // If conversation doesn't exist, create it from messagescript.js
          const originalConv = conversations.find(c => c.id === conversationId);
          if (originalConv) {
            foundConversation = { ...originalConv, messages: [] };
            storedConversations.update(convs => [...convs, foundConversation]);
          } else {
            // Redirect back if conversation is not found
            goto('/conversations');
            return;
          }
        }
  
        conversationStore.set(foundConversation);
      });

      return unsubscribe;
    });
  

    function sendMessage() {
        if (newMessage.trim()) {
            const message = {
                day: 'You',
                text: newMessage,
                timestamp: new Date().toISOString(),
            };
            
            conversationStore.update(conv => {
                conv.messages = [...conv.messages, message];
                return conv;
            });
            
            newMessage = '';

            updateConversations();
        }
    }

    function updateConversations() {
        storedConversations.update(convs => {
            const index = convs.findIndex(c => c.id === conversationId);
            if (index !== -1) {
                convs[index] = $conversationStore;
            }
            return convs;
        });
    }

    // Go back to the conversations list
    function goBack() {
        goto('/conversations');
    }
</script>

<svelte:head>
    <title>{$conversationStore ? $conversationStore.character.name : 'Conversation'}</title>
</svelte:head>

{#if $conversationStore}
    <div class="conversation">
        <!-- Header -->
        <div class="header">
            <button on:click={goBack}>Back</button>
            <span>{$conversationStore.character.name}</span>
        </div>

        <!-- Messages -->
        <div class="messages">
            {#each $conversationStore.messages as msg}
                <div class="message {msg.day === 'You' ? 'sent' : 'received'}">
                    <div class="message-content">
                        <span>{msg.text}</span>
                    </div>
                </div>
            {/each}
        </div>

        <!-- Input Area -->
        <div class="input-area">
            <input
                type="text"
                bind:value={newMessage}
                placeholder="Type a message..."
                on:keyup={(e) => e.key === 'Enter' && sendMessage()}
            />
            <button on:click={sendMessage}>Send</button>
        </div>
    </div>
{:else}
    <p>Loading...</p>
{/if}
  <style>
    /* Styles for the conversation */
    .conversation {
      display: flex;
      flex-direction: column;
      height: 100%;
    }
  
    .header {
      display: flex;
      align-items: center;
      padding: 10px;
    }
  
    .header button {
      margin-right: 10px;
    }
  
    .messages {
      flex: 1;
      overflow-y: auto;
      padding: 10px;
    }
  
    .message {
      margin-bottom: 10px;
    }
  
    .message.sent {
      text-align: right;
    }
  
    .message-content {
      display: inline-block;
      padding: 8px 12px;
      border-radius: 10px;
    }
  
    .message.sent .message-content {
      background-color: #dcf8c6;
    }
  
    .message.received .message-content {
      background-color: #f1f0f0;
    }
  
    .input-area {
      display: flex;
      padding: 10px;
    }
  
    .input-area input {
      flex: 1;
      padding: 10px;
      font-size: 14px;
    }
  
    .input-area button {
      padding: 0 20px;
      font-size: 14px;
    }
  </style>