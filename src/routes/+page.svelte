<script>
    import { onMount } from "svelte";
    import { goto } from "$app/navigation";
    import Feed from "../components/homepage/Feed.svelte";
    import Stories from "../components/homepage/Stories.svelte";

    // function homePage() {
    //         currentPage.style.display = "none";
    //         currentPage = document.getElementById("home-page");
    //         currentPage.style.display = "block";
    //     }

    //         let currentPage = document.getElementById("home-page");
    //     function reelMode() {
    //         alert("Android:\nSingle click to play the current reel\nDouble click to mute current reel")
    //         currentPage.style.display = "none";
    //         currentPage = document.getElementById("reel-page");
    //         currentPage.style.display = "block";

    //
    //     }

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
    <!-- instagram home home-page -->
    <div class="home-page" id="home-page">
        <header>
            <div class="logo-ico">
                <img src="icons/insta-name-logo.png" width="150" />
            </div>
            <div class="messages-ico">
                <img src="icons/heart.png" width="25" alt="" /> &nbsp;

                <img
                    src="icons/messenger.png"
                    width="25"
                    on:click={() => redirectTo("/conversations")}
                    alt="Messages"
                />
            </div>
        </header>
        <Stories />
        <Feed />
    </div>
</main>

<!-- end of the home home-page -->

<style>
    .home-page {
        position: relative;
        /* display: none; */
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
</style>
