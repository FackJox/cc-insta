<script>
    import Post from './Post.svelte';
  
    const posts = [
      {
        profilePic: "assets/akash.webp",
        username: "_akashh.x_",
        postImage: "assets/akash.webp",
        likedBy: "trainwithrc",
        caption: "Working on...💪",
        commentCount: 138
      },
      {
        profilePic: "assets/jay.jpg",
        username: "jaayxz.xt",
        postImage: "assets/jpost.webp",
        likedBy: "krushnasahane7",
        caption: "🤞✨",
        commentCount: 108
      },
      // Add more posts here
    ];
  </script>
  
  <main>
    <div class="feed">
      {#each posts as post}
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