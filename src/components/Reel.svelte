<script>
    import { onMount, createEventDispatcher } from 'svelte';
    import { mainCharacters } from '$lib/mainCharacters.js';
    import { feedCharacters } from '$lib/feedCharacters.js';
    import { comments } from '$lib/commentScript.js';
    import { goto } from '$app/navigation';

    export let src;
    export let index;
    
    let videoElement;
    let sectionElement;
    const dispatch = createEventDispatcher();
    
    function handleTap() {
        if (videoElement.paused) {
            const allVideos = document.querySelectorAll('video');
            allVideos.forEach(v => v.pause());
            videoElement.play();
        } else {
            videoElement.pause();
        }
    }

    const allCharacters = [...mainCharacters, ...feedCharacters];
    const randomCharacter = allCharacters[Math.floor(Math.random() * allCharacters.length)];
    const randomComment = comments[Math.floor(Math.random() * comments.length)];

    onMount(() => {
        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    videoElement.play();
                    dispatch('inview', { index });
                } else {
                    videoElement.pause();
                }
            });
        }, { threshold: 0.5 });

        observer.observe(sectionElement);

        return () => {
            observer.unobserve(sectionElement);
        };
    });

    function navigateToProfile(username) {
        goto(`/profile/${username}`);
    }
</script>

<div class="section" bind:this={sectionElement}>
    <video {src} loop bind:this={videoElement}
           on:click={handleTap}>
        Video cannot be played.
    </video>

    <div class="aside">
        <img src="/icons/heart.png" width="25" alt="Like" />
        <img src="/icons/chat.png" width="25" alt="Comment" />
        <img src="/icons/share.png" width="25" alt="Share" />
        <img src="/icons/dots.png" width="25" alt="More" />
    </div>
    <div class="details">
        <div class="user">
            <img src={randomCharacter.profilePic} width="25px" alt="Profile" on:click={() => navigateToProfile(randomCharacter.username)} />
            <b on:click={() => navigateToProfile(randomCharacter.username)}>{randomCharacter.username}</b>
            <button on:click={() => navigateToProfile(randomCharacter.username)}>Follow</button>
        </div>
        <div class="description">
            {randomComment}
        </div>
    </div>
</div>


<style>
     .section {
        position: relative;
        width: 100%;
        height: calc(100vh - 20px); /* Subtract gap height */
        margin-bottom: 20px; /* Add vertical gap */
        scroll-snap-align: start;

    }

    video {
        width: 100%;
        height: 100%;
        object-fit: cover;
    }

    .aside {
        display: flex;
        flex-direction: column;
        gap: 20px;
        position: absolute;
        right: 10px;
        bottom: 40px; /* Lowered position */
    }

    .aside img {
        filter: drop-shadow(1px 1px 1px white);
        cursor: pointer;
    }

    .reel-page div .details {
    width: 80%;
    padding: 10px;
    color: rgb(255, 255, 255);
    display: flex;
    flex-direction: column;
    gap: 15px;
    position: absolute;
    bottom: 36px;
}

.reel-page div .details .user {
    display: flex;
    gap: 10px;

}

.reel-page div .details .user img {
    border-radius: 50%;
}
.reel-page div .details button{
    color: aliceblue;
    background: transparent;
    font-weight: bold;
    border-radius: 5px;
    padding: 5px 10px;
    border: 1px solid;
}

.reel-page div .details .description {
    text-wrap: wrap;
}
</style>