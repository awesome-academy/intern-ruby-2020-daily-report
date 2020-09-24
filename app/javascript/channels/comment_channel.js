import consumer from './consumer'

consumer.subscriptions.create({ channel: 'CommentChannel' }, {
  received(data) {
    $('#all-comments-' + data.report_id).prepend(data.html);
    $('#side-bar-new-comment-notify').html(`<span>${data.num_of_notify}</span>`);
    $('#report-' + data.report_id).addClass('report_new_comment');
  }
})
