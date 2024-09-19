<!-- Reel.svelte -->
<script>
    export let src;
    
    let videoElement;
    
    function handleMouseOver() {
        if (videoElement.paused) {
            const allVideos = document.querySelectorAll('video');
            allVideos.forEach(v => v.pause());
            videoElement.play();
        }
    }
    
    function handleDoubleClick() {
        videoElement.muted = !videoElement.muted;
    }
    </script>
    
    <div class="section">
        <video {src} width="100%" loop bind:this={videoElement}
               on:mouseover={handleMouseOver}
               on:dblclick={handleDoubleClick}>
            Video cannot be played
        </video>
        <div class="aside">
            <img src="icons/heart.png" width="25" alt="" />
            <img src="icons/chat.png" width="25" alt="" />
            <img src="icons/share.png" width="25" alt="" />
            <img src="icons/dots.png" width="25" alt="" />
        </div>
        <div class="details">
            <div class="user">
                <img src="assets/aditya.jpg" width="25px" alt="" />
                <b>Username</b>
                <button>Follow</button>
            </div>
            <div class="description">
                Lorem, ipsum dolor sit amet consectetur adipisicing elit.
                Natus, nisi.
            </div>
        </div>
    </div>