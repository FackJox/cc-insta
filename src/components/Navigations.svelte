<script>
    import { goto } from '$app/navigation';

    function redirectTo(path) {
        goto(path);
    }
</script>

<main>
    <!-- navigations -->
    <div class="navigations" id="navigations">
        <img src="/icons/homepage.png" alt="Home" width="25" height="25" id="home" on:click={() => redirectTo('/')}>
        <img src="/icons/search.png" alt="Search" width="25" height="25" on:click={() => redirectTo('/search')}>
        <img src="/icons/add.png" alt="Add" width="25" height="25"on:click={() => alert('Page not available...!\nYou can enjoy the reels ❣')}>
        <img src="/icons/reel.webp" alt="Reels" width="25" height="25" id="reel" on:click={() => redirectTo('/reels')}>
        <img src="/assets/krish.jpg" width="25" height="25" style="border-radius: 50%;" on:click={() => redirectTo('/profile/ceci.love')} alt="krish">
    </div>
    <!-- end navigations -->
</main>

<style>
.navigations {
    width: 100%;
    height: 40px;
    background-color: rgb(255, 255, 255);
    position: sticky;
    bottom: 0px;
    margin-top: px;
    display: flex;
    flex-direction: row;
    align-items: center;
    justify-content: space-around;
}
</style>