<script>
    import { onMount, getContext } from "svelte";
    import { goto } from "$app/navigation";
    import Feed from "../components/homepage/Feed.svelte";
    import Stories from "../components/homepage/Stories.svelte";

    const storedConversations = getContext('storedConversations');

    // Check for unread messages across all conversations
    $: hasUnreadMessages = $storedConversations.some(conversation => 
        conversation.messages.some(msg => !msg.read)
    );

    function redirectTo(path) {
        goto(path);
    }

    onMount(() => {
        if ("Notification" in window) {
            Notification.requestPermission().then((permission) => {
                if (permission === "granted") {
                    // Set up push notifications
                }
            });
        }
    });
</script>

<main>
    <div class="home-page" id="home-page">
        <header>
            <div class="logo-ico">
                <img src="/icons/insta-name-logo.png" width="150" alt="Instagram" />
            </div>
            <div class="messages-ico">
                <img src="/icons/heart.png" width="25" alt="Notifications" /> &nbsp;

                <div class="messenger-container">
                    <img
                        src="/icons/messenger.png"
                        width="25"
                        on:click={() => redirectTo("/conversations")}
                        alt="Messages"
                    />
                    {#if hasUnreadMessages}
                        <div class="unread-indicator"></div>
                    {/if}
                </div>
            </div>
        </header>
        <Stories />
        <Feed />
    </div>
</main>

<style>
    .home-page {
        position: relative;
    }

    .home-page header {
    display: flex;
    background-color: white;
    flex-direction: row;
    place-items: center;
    place-content: space-between;
    padding: 10px;
    position: sticky;
    top: 0;
    z-index: 1;
}

    img {
        cursor: pointer;
    }

    .messenger-container {
        position: relative;
        display: inline-block;
    }

    .unread-indicator {
        position: absolute;
        top: -2px;
        right: -2px;
        width: 10px;
        height: 10px;
        background-color: red;
        border-radius: 50%;
    }
</style>