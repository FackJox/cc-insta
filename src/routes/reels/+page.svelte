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
    /* text-shadow: 0px 0px 3px white; */
    
}

.reel-page .camera {
    position: fixed;
    margin-left: 10px;
    margin-top: 10px;
    z-index: 3;
}

.reel-page>div {
    position: relative;
    height: 90vh;
    width: 100%;
    display: flex;
    flex-direction: column;
    place-content: center;
    scroll-snap-align: start;
}

.reel-page div .aside {
    display: flex;
    flex-direction: column;
    gap: 20px;
    position: absolute;
    right: 10px;
    bottom: 100px;
}
.reel-page div .aside img{
    filter: drop-shadow(1px 1px 1px white);
}

.reel-page div .details {
    width: 80%;
    padding: 10px;
    color: rgb(255, 255, 255);
    display: flex;
    flex-direction: column;
    gap: 15px;
    position: absolute;
    bottom: 45px;
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
