<script>
  import { goto } from '$app/navigation';

  function back() {
    goto('/');
  }
</script>

<div class="message-header">
  <div class="msg-header">
    <img src="/icons/back.png" alt="" width="25" on:click={back}>
    <span>ceci.love</span>
  </div>
  
  <input type="text" id="search-msg" placeholder="Search">
  
  <div class="buttons">
    <div class="messages">Messages</div>
    <div class="requests">Requests</div>
  </div>
</div>

<style>
  .message-header {
    position: sticky;
    top: 0;
    background-color: white;
    z-index: 10;
    width: 100%;
    padding: 10px;
    box-sizing: border-box;
  }

  .msg-header {
    font-weight: bold;
    display: flex;
    flex-direction: row;
    gap: 20px;
    align-items: center;
  }

  #search-msg {
    height: 30px;
    margin: 20px 0;
    padding: 3px 10px;
    width: 100%;
    border-radius: 7px;
    outline: none;
    border: none;
    background-color: rgb(222, 224, 226);
    box-sizing: border-box;
  }

  .buttons {
    display: flex;
    flex-direction: row;
    justify-content: space-between;
  }

  .buttons .messages {
    font-weight: bold;
  }

  .buttons .requests {
    color: rgb(0, 140, 255);
    cursor: pointer;
  }
</style>