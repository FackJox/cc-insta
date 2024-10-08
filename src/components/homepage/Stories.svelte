<script>
  import { feedCharacters } from '$lib/feedCharacters.js';
  import { mainCharacters } from '$lib/mainCharacters.js';
  import { conversations } from '$lib/messageScript.js';
  import { fade, fly } from 'svelte/transition';
  import { cubicIn } from 'svelte/easing';
  import { onDestroy } from 'svelte';

  // Combine characters from both sources
  let allCharacters = [
    ...feedCharacters,
    ...mainCharacters
  ];

  // Filter out "ceci.love" from allCharacters
  allCharacters = allCharacters.filter(character => character.username !== "ceci.love");

  // Shuffle the array to get random order
  allCharacters = allCharacters.sort(() => Math.random() - 0.5);

  // Select first 7 characters (excluding "Your story")
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

  let currentStoryIndex = -1;
  let storyInterval;
  let direction = 1;

  function cubeRotation(node, { duration }) {
    return {
      duration,
      css: t => {
        const eased = cubicInOut(t);
        const rotateY = direction * 90 * (1 - eased);
        return `
          transform: perspective(1000px) rotateY(${rotateY}deg);
          opacity: ${eased};
        `;
      }
    };
  }

  function openStories(index) {
    currentStoryIndex = index;
    startStoryInterval();
  }

  function startStoryInterval() {
    clearInterval(storyInterval);
    storyInterval = setInterval(() => {
      direction = 1;
      currentStoryIndex = (currentStoryIndex + 1) % storyCharacters.length;
      if (currentStoryIndex === 0) {
        closeStories();
      }
    }, 4000);
  }

  function closeStories() {
    currentStoryIndex = -1;
    clearInterval(storyInterval);
  }

  onDestroy(() => {
    clearInterval(storyInterval);
  });
</script>

<main>
  <div class="story-section">
    {#each storyCharacters as character, index}
      <div class="story" on:click={() => openStories(index)}>
        <img src={getRandomImage(character)} width="70" height="70" alt="">
        <label for="username">{character.username}</label>
        {#if index === 0}
          <img src="/icons/plus.png" width="20" class="plus">
        {/if}
      </div>
    {/each}
  </div>

  {#if currentStoryIndex >= 0}
    <div class="fullscreen-story" on:click={closeStories}>
      {#key currentStoryIndex}
        <div 
          class="story-image"
          in:fly={{ x: 300, duration: 200, easing: cubicIn }}
          out:fly={{ x: -300, duration: 200, easing: cubicIn }}
        >
          <img src={getRandomImage(storyCharacters[currentStoryIndex])} alt="Full-screen story">
          <p class="story-username">{storyCharacters[currentStoryIndex].username}</p>
        </div>
      {/key}
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

 .fullscreen-story {
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

  .story-image {
    position: relative;
    width: 100%;
    height: 100%;
    display: flex;
    justify-content: center;
    align-items: center;
  }

  .story-image img {
    max-width: 100%;
    max-height: 100%;
    object-fit: contain;
  }

  .story-username {
    position: absolute;
    top: 20px;
    left: 20px;
    color: white;
    font-size: 18px;
    font-weight: bold;
  }
</style>