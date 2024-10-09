<script>
    import { onMount } from 'svelte';
    import Reel from '../../components/Reel.svelte';

    const videos = [
        "assets/videos/v1.mp4",
        "assets/videos/v2.mp4",
        "assets/videos/v3.mp4",
        "assets/videos/v4.mp4",
        "assets/videos/v5.mp4",
        "assets/videos/v9.mp4"
    ];

    let reelPage;
    let currentIndex = 0;

    function handleInView(event) {
        currentIndex = event.detail.index;
    }

    function scrollToNextReel() {
        if (currentIndex < videos.length - 1) {
            currentIndex++;
            reelPage.children[currentIndex].scrollIntoView({ behavior: 'smooth' });
        }
    }

    function scrollToPreviousReel() {
        if (currentIndex > 0) {
            currentIndex--;
            reelPage.children[currentIndex].scrollIntoView({ behavior: 'smooth' });
        }
    }

    onMount(() => {
        const handleWheel = (event) => {
            event.preventDefault();
            if (event.deltaY > 0) {
                scrollToNextReel();
            } else {
                scrollToPreviousReel();
            }
        };

        reelPage.addEventListener('wheel', handleWheel, { passive: false });

        return () => {
            reelPage.removeEventListener('wheel', handleWheel);
        };
    });
</script>

<main>
    <div class="reel-page" id="reel-page" bind:this={reelPage}>
        <img src="icons/icons8-camera-50.png" alt="" width="30" class="camera" />
        {#each videos as video, index}
            <Reel src={video} {index} on:inview={handleInView} />
        {/each} 
    </div>
</main>

<style>
    .reel-page {
        display: block;
        position: relative;
        scroll-snap-type: y mandatory;
        overflow-y: scroll;
        width: 100%;
        height: 100vh;
        scrollbar-width: none;
        -ms-overflow-style: none;
    }

    .reel-page::-webkit-scrollbar {
        display: none;
    }
    
    .reel-page .camera {
        position: fixed;
        top: 10px;
        left: 16px;
        z-index: 3;
    }
</style>