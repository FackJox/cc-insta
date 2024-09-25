<script>
  import Post from './Post.svelte';
  import { getContext } from 'svelte';

  const storedPosts = getContext('storedPosts');
</script>

<main>
  <div class="feed">
    {#each $storedPosts as post}
      <Post {...post} />
    {/each}
  </div>
</main>

<style>
  .feed {
    display: flex;
    flex-direction: column;
    color: rgb(27, 27, 27);
    font-size: 11pt;
  }
</style>