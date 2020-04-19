import consumer from "./consumer"

consumer.subscriptions.create("RequestsChannel", {

  connected() {
    // Called when the subscription is ready for use on the server
    console.log("---------- Connected to requests channel");
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
    console.log("---------- Disconnected from requests channel");
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    console.log("---------- Recieved data on requests channel:", data);
    let page = data['page']
    let queue = data['queue']

    if (page) {
      let element = $('#song_' + page);
      element.addClass('requested');
      // element.prop( "disabled", true );
      if (queue) {
        $('#song_' + page + ' .queue_text').attr('queue', queue);
      }
    }
    $('.queue_text').each(function () {
      let q = $(this).attr('queue');
      if (q !== '') {
        q = parseInt(q);
        let q_change = data['change_queue'];

        if (q_change) {
          q = q + q_change;
          $(this).attr('queue', q);
        }

        updateQueueText($(this), q);
      }
    });
  }
});

