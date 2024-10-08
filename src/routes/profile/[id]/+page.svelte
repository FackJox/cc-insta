<script>
    import { page } from '$app/stores';
    import { goto } from '$app/navigation';
    import { mainCharacters } from '$lib/mainCharacters.js';
    import { feedCharacters } from '$lib/feedCharacters.js';
    import { fade } from 'svelte/transition';

    // Combine both arrays
    const allCharacters = [...mainCharacters, ...feedCharacters];
  
    $: profile = allCharacters.find(char => char.username === $page.params.id) || allCharacters[0];
    $: isCeciLove = profile.username === 'ceci.love';
  
    function back() {
      goto('/');
    }

    let selectedImage = null;

function openImage(image) {
  selectedImage = image;
}

function closeImage() {
  selectedImage = null;
}
  </script>
       
  <main>
    <!-- profile Page -->
    <div class="profile-page" id="profile-page">
        <div class="header">
            <img src="/icons/back.png" alt="" width="25" on:click={back}>
            <label for="name">{profile.username}</label>
            <div class="placeholder"></div>
        </div>
        <div class="profile-box">
            <div class="row-1">
                <div class="col"><img src={profile.profilePic} alt="" width="80px"></div>
                <div class="col"><b>{profile.posts || '0'}</b> <label>Posts</label></div>
                <div class="col"><b>{profile.followers || '0'}</b><label>Followers</label></div>
                <div class="col"><b>{profile.following || '0'}</b><label>Following</label></div>
            </div>
            <div class="row-2">
                <label for="name">{profile.name}</label>
                <label for="second insta id">@{profile.username}</label>
            </div>
            {#if isCeciLove}
            <div class="row-3">
                <button>Edit profile</button>
                <button>Share profile</button>
            </div>
            {/if}
        </div>
        <div class="highlights">
            {#each profile.highlights as highlight}
                <div>
                    <img src={highlight.picture} alt="" width="60px" height="60px">
                    <label for="myself">{highlight.title}</label>
                </div>
            {/each}
        </div>
        <section class="post-reels">
            <div class="row-1">
                <img src="/icons/grid.png" alt="" width="25px">
                <img src="/icons/reel.webp" alt="" width="30px">
                <img src="/icons/tag.png" alt="" width="35px">
            </div>
            <div class="row-2">
                {#each profile.postImages as postImage}
                    <div class="post-image" on:click={() => openImage(postImage)}>
                        <img src={postImage} alt="">
                    </div>
                {/each}
            </div>
        </section>
    </div>
    <!-- End of the profile Page -->


 {#if selectedImage}
    <div class="fullscreen-image" on:click={closeImage} transition:fade>
      <img src={selectedImage} alt="Full-screen image">
    </div>
  {/if}
</main>
  
  <style>

.fullscreen-image {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.9);
    display: flex;
    justify-content: center;
    align-items: center;
    z-index: 1000;
  }

  .fullscreen-image img {
    max-width: 100%;
    max-height: 100%;
    object-fit: contain;
  }
      
  .profile-page{
      width: calc(100% - 20px);
      height: 90vh;
      overflow: auto;
      color: black;
      padding: 10px;
      display: block;
  }
  .profile-page .header {
      display: flex;
      justify-content: space-between;
      align-items: center;
  }
  .profile-page .header img {
      cursor: pointer;
  }
  .profile-page .header label {
      flex-grow: 1;
      text-align: center;
      font-weight: bold;
  }
  .profile-page .header .placeholder {
      width: 25px;
  }
  .profile-page .profile-box .row-1{
      margin-top: 30px;
      display: flex;
      flex-direction: row;
      place-content: space-between;
      align-items: center;
  }
  .profile-page .row-1 .col{
      display: flex;
      flex-direction: column;
      align-items: center;
  }
  .profile-page .profile-box .row-1 .col:nth-child(1) img{
      border-radius: 50%;
  }
  .profile-page .profile-box .row-2{
      display: flex;
      flex-direction: column;
  }
  .profile-page .profile-box .row-2 label:nth-child(1){
      font-weight: bold;
      color: rgb(46, 46, 46);
  }
  .profile-page .profile-box .row-2 label:nth-child(2){
      color: rgb(9, 9, 41);
  }
  .profile-page .profile-box .row-3{
      display: flex;
      flex-direction: row;
      place-content: space-between;
      margin-top: 20px;
  }
  .profile-page .profile-box .row-3 button{
      width: 45%;
      padding: 5px;
      border: none;
      outline: none;
      border-radius: 5px;
      font-weight: bold;
      color: rgb(44, 44, 44);
  }
  
  .profile-page .highlights{
      margin-top: 20px;
      display: flex;
      flex-direction: row;
      overflow-y: scroll;
      align-items: center;
      gap: 20px;
  }
  .profile-page .highlights div{
      display: flex;
      flex-direction: column;
      gap: 5px;
      align-items: center;    
      font-size: 10pt;
  }
  .profile-page .highlights div img{
      border-radius: 50%;
  }
  .profile-page .post-reels{
      margin-top: 20px;
      height: auto;
      width: 100%;
      overflow-y: scroll;
  }
  .profile-page .post-reels .row-1{
      width: 100%;
      display: flex;
      flex-direction: row;
      place-content: space-around;
      align-items: center;
  }
  .profile-page .post-reels .row-2{
      margin-top: 20px;
      width: 100%;
      display: flex;
      flex-wrap: wrap;
      gap: 2px;
  }
  .profile-page .post-reels .row-2 .post-image {
      width: calc(33.33% - 2px);
      aspect-ratio: 1 / 1;
      overflow: hidden;
  }
  .profile-page .post-reels .row-2 .post-image img {
      width: 100%;
      height: 100%;
      object-fit: cover;
  }
  </style>