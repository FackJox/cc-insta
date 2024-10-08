<script>
  import { feedCharacters } from '$lib/feedCharacters.js';
  import { mainCharacters } from '$lib/mainCharacters.js';
  import { conversations } from '$lib/messageScript.js';
  import { fade } from 'svelte/transition';
  import { onDestroy } from 'svelte';

  // Combine characters from both sources
  let allCharacters = [
    ...feedCharacters,
    ...mainCharacters
  ];

  // Shuffle the array to get random order
  allCharacters = allCharacters.sort(() => Math.random() - 0.5);

  // Select first 8 characters (including "Your story")
  let storyCharacters = allCharacters.slice(0, 7);

  // Add "Your story" at the beginning
  storyCharacters.unshift({
    profilePic: "/assets/ceci/ceci_01.png",
    username: "Your story"
  });

  // Function to get a random image for each character
  function getRandomImage(character) {
    if (character.postImages && character.postImages.length > 0) {
      return character.postImages[Math.floor(Math.random() * character.postImages.length)];
    }
    return character.profilePic;
  }

  let selectedImage = null;
  let timer;

  function openImage(image) {
    selectedImage = image;
    
    // Clear any existing timer
    if (timer) clearTimeout(timer);
    
    // Set a new timer to close the image after 5 seconds
    timer = setTimeout(() => {
      closeImage();
    }, 5000);
  }

  function closeImage() {
    selectedImage = null;
    if (timer) clearTimeout(timer);
  }

  // Clean up the timer when the component is destroyed
  onDestroy(() => {
    if (timer) clearTimeout(timer);
  });
</script>

<main>
  <div class="story-section">
      {#each storyCharacters as character, index}
          <div class="story" on:click={() => openImage(getRandomImage(character))}>
              <img src={getRandomImage(character)} width="70" height="70" alt="">
              <label for="username">{character.username}</label>
              {#if index === 0}
                  <img src="/icons/plus.png" width="20" class="plus">
              {/if}
          </div>
      {/each}
  </div>

  {#if selectedImage}
    <div class="fullscreen-image" on:click={closeImage} transition:fade>
      <img src={selectedImage} alt="Full-screen story">
    </div>
  {/if}
</main>

<style>
 .story-section {
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
  cursor: pointer;
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
</style>