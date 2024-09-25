<script>
  import { goto } from '$app/navigation';

  function back() {
    goto('/');
  }
</script>

<div class="conversations">
  <div class="msg-header">
    <img src="icons/back.png" alt="" width="25" on:click={back}>
    <span>ceci.love</span>
  </div>
  
  <input type="text" id="search-msg" placeholder="Search">
  
  <div class="row-1">
    <div class="col-1">Messages</div>
    <div class="col-2">Requests</div>
  </div>
</div>

<style>
  .conversations {
    width: calc(100% - 20px);
    overflow: auto;
    color: black;
    padding: 10px;
  }

  .conversations .msg-header {
    font-weight: bold;
    display: flex;
    flex-direction: row;
    gap: 20px;
  }

  .conversations #search-msg {
    height: 30px;
    margin: 20px 0;
    padding: 3px 10px;
    width: 100%;
    border-radius: 7px;
    outline: none;
    border: none;
    background-color: rgb(222, 224, 226);
  }

  .conversations .row-1 {
    display: flex;
    flex-direction: row;
    place-content: space-between;
  }

  .conversations .row-1 .col-1 {
    font-weight: bold;
  }

  .conversations .row-1 .col-2 {
    color: rgb(0, 140, 255);
    cursor: pointer;
  }
</style>