<main>
    <div class="story-section">
        <div class="story">
            <img src="assets/krish.jpg" width="70" height="70" alt="">
            <label for="username">Your story</label>
            <img src="icons/plus.png" width="20" class="plus">
        </div>
        <div class="story">
            <img src="assets/jay.jpg" width="70" height="70" alt="">
            <label for="username">jaayxz.xt</label>
        </div>
        <div class="story">
            <img src="assets/akash.webp" width="70" height="70" alt="">
            <label for="username">_akashh.x_</label>
        </div>
        <div class="story">
            <img src="assets/aditya.jpg" width="70" height="70" alt="">
            <label for="username">aditya_ekhande_</label>
        </div>
        <div class="story">
            <img src="assets/unknown-profile.png" width="70" height="70" alt="">
            <label for="username">__sanket.s</label>
        </div>
        <div class="story">
            <img src="assets/abp.jpg" width="70" height="70" alt="">
            <label for="username">abpmajhatv</label>
        </div>
        <div class="story">
            <img src="assets/teddy.png" width="70" height="70" alt="">
            <label for="username">anamika</label>
        </div>
        <div class="story">
            <img src="assets/tripti.jpg" width="70" alt="">
            <label for="username">tripti_dimri</label>
        </div>

    </div>
</main>

<style>
       .story-section {
        /* border: 1px solid black; */
        width: 100%;
        height: auto;
        position: relative;
        display: flex;
        flex-direction: row;
        flex-wrap: nowrap;
        overflow-x: auto;
        padding: 1px;
    }
    
    .story-section .story {
        background: linear-gradient(45deg, yellow, rgb(216, 19, 19));
        border-radius: 50%;
        height: auto;
        width: auto;
        display: flex;
        flex-direction: column;
        place-content: center;
        align-items: center;
        margin: 3px;
        margin-bottom: 20px;
        position: relative;
    }
    
    .story-section .story img {
        margin: 3px;
        border: 3px solid white;
        border-radius: 50%;
    }
    
    .story-section .story label {
        width: 80px;
        color: black;
        font-size: 11px;
        text-align: center;
        overflow: hidden;
        position: absolute;
        bottom: -15px;
    }
    
    .story-section .story .plus {
        position: absolute;
        bottom: 5px;
        right: 0;
    }
</style>