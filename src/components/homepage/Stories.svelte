<script>
    import { feedCharacters } from '$lib/feedCharacters.js';
    import { mainCharacters } from '$lib/mainCharacters.js';
    import { conversations } from '$lib/messageScript.js';
  
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
  </script>
  
  <main>
      <div class="story-section">
          {#each storyCharacters as character, index}
              <div class="story">
                  <img src={getRandomImage(character)} width="70" height="70" alt="">
                  <label for="username">{character.username}</label>
                  {#if index === 0}
                      <img src="icons/plus.png" width="20" class="plus">
                  {/if}
              </div>
          {/each}
      </div>
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