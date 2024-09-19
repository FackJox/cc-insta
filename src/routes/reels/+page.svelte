<script>
    import Reel from '../../components/Reel.svelte';
    </script>
    
    <main>
        <div class="reel-page" id="reel-page">
            <img src="icons/icons8-camera-50.png" alt="" width="30" class="camera" />
            <Reel src="assets/videos/v1.mp4" />
            <Reel src="assets/videos/v2.mp4" />
            <Reel src="assets/videos/v3.mp4" />
            <Reel src="assets/videos/v4.MP4" />
            <Reel src="assets/videos/v5.mp4" />
            <Reel src="assets/videos/v9.mp4" />
        </div>
    </main>
    
<style>
    .reel-page {
        display: block;
        position: relative;
        scroll-snap-type: both mandatory;
        overflow-y: scroll;
        overflow-x: scroll;
        width: 100%;
        height: 90vh;
        padding-top: 50px; /* Add padding to the top */
    }
    
    .reel-page .camera {
        position: fixed;
        top: 10px; /* Change margin-top to top */
        left: 10px; /* Change margin-left to left */
        z-index: 3;
    }
    
    .reel-page > div {
        position: relative;
        height: calc(90vh - 50px); /* Adjust height to account for padding */
        width: 100%;
        display: flex;
        flex-direction: column;
        place-content: center;
        scroll-snap-align: start;
    }
    </style>
