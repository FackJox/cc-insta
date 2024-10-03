<script>
    import { onMount, getContext } from 'svelte';
    import { page } from '$app/stores';
    import { goto } from '$app/navigation';
    import { conversations } from '$lib/messageScript.js';
    
    let conversationId;
    let conversation = null;
    let newMessage = '';
    const storedConversations = getContext('storedConversations');
    
    function navigateToProfile(character) {
        if (character && character.username) {
            goto(`/profile/${character.username}`);
        } else {
            console.error('Username not found for character:', character);
        }
    }
    
    $: conversationId = $page.params.id;
    
    // Make `conversation` reactive to changes in `storedConversations`
    $: conversation = $storedConversations.find(c => c.id === conversationId);
    
    // Mark messages as read when viewing the conversation
    $: if (conversation) {
        // Check if there are any unread messages
        const hasUnreadMessages = conversation.messages.some(msg => !msg.read);
        if (hasUnreadMessages) {
            // Mark all messages as read
            storedConversations.update(convs => {
                return convs.map(conv => {
                    if (conv.id === conversationId) {
                        return {
                            ...conv,
                            messages: conv.messages.map(msg => ({ ...msg, read: true }))
                        };
                    }
                    return conv;
                });
            });
        }
    }
    
    function sendMessage() {
        if (newMessage.trim()) {
            const message = {
                day: 'You',
                text: newMessage,
                timestamp: new Date().toISOString(),
                read: true,
            };
            
            storedConversations.update(convs => {
                return convs.map(conv => {
                    if (conv.id === conversationId) {
                        return {
                            ...conv,
                            messages: [...conv.messages, message]
                        };
                    }
                    return conv;
                });
            });
            
            newMessage = '';
        }
    }
    
    function goBack() {
        goto('/conversations');
    }
    
    // Function to format the timestamp
    function formatLastMessaged(date) {
        const now = new Date();
        const diffInMinutes = Math.floor((now - date) / (1000 * 60));

        if (diffInMinutes < 1) return 'Just now';
        if (diffInMinutes < 60) return `${diffInMinutes}m ago`;
        if (diffInMinutes < 1440) {
            const hours = Math.floor(diffInMinutes / 60);
            return `${hours}h ago`;
        }
        return date.toLocaleDateString();
    }
</script>



{#if conversation}
    <div class="conversation">
        <!-- Header -->
        <div class="header">
            <button on:click={goBack} class="back-button">
                <img src="/icons/back.png" alt="Back" width="25">
            </button>
            <div class="user-info">
                <img src={conversation.character.image} alt={conversation.character.name} class="profile-pic">
                <span class="username" on:click={() => navigateToProfile(conversation.character)}>
                    {conversation.character.name}
                </span>
            </div>
        </div>

        <!-- Messages -->
        <div class="messages-container">
            <div class="messages">
                {#each conversation.messages as msg}
                    <div class="message {msg.day === 'You' ? 'sent' : 'received'}">
                        <div class="message-content">
                            <span class="message-text">{msg.text}</span>
                            <span class="timestamp">{formatLastMessaged(new Date(msg.timestamp))}</span>
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


.message {
        margin-bottom: 12px; /* Increased margin between messages */
        display: flex;
    }

    .message.sent {
        justify-content: flex-end;
    }

    .message-content {
        max-width: 70%;
        min-width: 60px; /* Add minimum width */
        padding: 8px 12px;
        border-radius: 22px;
        font-size: 14px;
        line-height: 1.4;
        position: relative;
    }

    .message-text {
        display: block;
        margin-bottom: 15px; /* Add space for the timestamp */
        word-wrap: break-word; /* Ensure long words don't overflow */
    }

    .message.sent .message-content {
        background-color: #98dd63;
        color: #000;
    }

    .message.received .message-content {
        background-color: #3897f0;
        color: #fff;
    }

    .timestamp {
        font-size: 10px;
        color: #8e8e8e;
        position: absolute;
        bottom: 4px;
        right: 12px;
        white-space: nowrap;
    }

    .message.received .timestamp {
        color: rgba(255, 255, 255, 0.7); /* Adjust color for better visibility on blue background */
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