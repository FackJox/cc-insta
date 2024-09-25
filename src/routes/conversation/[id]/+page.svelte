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
            <button on:click={goBack} class="back-button">
                <img src="/icons/back.png" alt="Back" width="25">
            </button>
            <div class="user-info">
                <img src={$conversationStore.character.image} alt={$conversationStore.character.name} class="profile-pic">
                <span class="username">{$conversationStore.character.name}</span>
            </div>
        </div>

        <!-- Messages -->
        <div class="messages-container">
            <div class="messages">
                {#each $conversationStore.messages as msg}
                    <div class="message {msg.day === 'You' ? 'sent' : 'received'}">
                        <div class="message-content">
                            <span>{msg.text}</span>
                        </div>
                    </div>
                {/each}
            </div>
        </div>

   <!-- Input Area -->
   <div class="input-container">
    <div class="input-area">
        <input
            type="text"
            bind:value={newMessage}
            placeholder="Message..."
            on:keyup={(e) => e.key === 'Enter' && sendMessage()}
        />
        <button on:click={sendMessage} class="send-button" disabled={!newMessage.trim()}>Send</button>
    </div>
</div>
    </div>
{:else}
    <p>Loading...</p>
{/if}

<style>
    .conversation {
        display: flex;
        flex-direction: column;
        height: calc(100vh - 40px); /* Subtract the height of the navigation bar */
        background-color: #fff;
        font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;
    }

    .header {
        display: flex;
        align-items: center;
        padding: 10px 16px;
        border-bottom: 1px solid #dbdbdb;
        background-color: #fff;
    }

    .back-button {
        background: none;
        border: none;
        cursor: pointer;
        padding: 0;
        margin-right: 16px;
    }

    .user-info {
        display: flex;
        align-items: center;
    }

    .profile-pic {
        width: 32px;
        height: 32px;
        border-radius: 50%;
        margin-right: 12px;
    }

    .username {
        font-weight: 600;
        font-size: 16px;
    }

    .messages-container {
    flex: 1;
    overflow-y: auto;
    display: flex;
    flex-direction: column-reverse;
    background-color: #fff;
}


.messages {
    padding: 16px;
}

    .message {
        margin-bottom: 8px;
        display: flex;
    }

    .message.sent {
        justify-content: flex-end;
    }

    .message-content {
        max-width: 70%;
        padding: 8px 12px;
        border-radius: 22px;
        font-size: 14px;
        line-height: 1.4;
    }

    .message.sent .message-content {
        background-color: #98dd63;
        color: #000;
    }

    .message.received .message-content {
        background-color: #3897f0;
        color: #fff;
    }

    .input-container {
        position: sticky;
        bottom: 0;
        background-color: #fff;
        border-top: 1px solid #dbdbdb;
        padding-bottom: 10px; /* Add some padding at the bottom */

    }

    .input-area {
        display: flex;
        align-items: center;
        padding: 10px 16px;
    }

    .input-area input {
        flex: 1;
        padding: 10px 12px;
        font-size: 14px;
        border: 1px solid #dbdbdb;
        border-radius: 22px;
        outline: none;
        background-color: #f5f5f5;
    }

    .input-area input::placeholder {
        color: #8e8e8e;
    }

    .send-button {
        background: none;
        border: none;
        color: #3897f0;
        font-weight: 600;
        font-size: 14px;
        padding: 0 0 0 16px;
        cursor: pointer;
        min-width: 44px;
    }

    .send-button:disabled {
        color: #b2dffc;
    }
</style>