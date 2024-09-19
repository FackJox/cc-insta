<!-- MessageItem.svelte -->
<script>
  export let msg;
</script>

<div class="row">
  <div class="col"><img src={msg.image} alt="" width="50"></div>
  <div class="col">
    <label>{msg.name}</label><br>
    <span>{msg.text}</span>
  </div>
  <div class="col">
    <img src="icons/icons8-camera-50.png" alt="" width="25px">
  </div>
</div>

<!-- MessageItem.svelte -->
<style>
  .row {
    display: flex;
    flex-direction: row;
    gap: 10px;
    margin-top: 20px;
    position: relative;
  }

  .row .col:nth-child(2) {
    color: rgb(47, 47, 48);
    font-size: 14px;
    padding: 4px 0;
  }

  .row .col:nth-child(3) {
    position: absolute;
    right: 5px;
    top: 15px;
  }

  .row .col:nth-child(1) img {
    border-radius: 50%;
  }
</style>