import $ from 'jquery';
import { Socket } from "phoenix";

let socket = new Socket("/socket", { params: { token: window.userToken } });
socket.connect();

const token = $('#js-form-token').val()
const channel = socket.channel(`thread:${token}`, {});

channel
  .join()
  .receive("ok", resp => {
    console.log("Joined successfully", resp);
  })
  .receive("error", resp => {
    console.log("Unable to join", resp);
  });

channel.on('tweet_posted', payload => {
  const linkHtml = `<a href="${payload.link}" target="_blank">${payload.link}</a>`
  const $tweetLink = $(`#js-tweet-link-${payload.index}`);
  $tweetLink.parent().removeClass('is-hidden');
  $tweetLink.html(linkHtml);

  const total = $('.tweets-container').find('textarea').length;
  if (parseInt(payload.index, 10) === total) {
    $('#js-submit-thread')
      .removeClass('is-loading')
      .prop('disabled', true)
      .text('Done!');
  }
});

const submitBtn = $('#js-submit-thread');
submitBtn.on('click', (e) => {
  e.preventDefault();
  submitBtn.addClass('is-loading');
  let formData = {
    token: $('#js-form-token').val(),
    tweets: [],
  };
  $('.js-tweet').each((i, el) => {
    const $el = $(el)
    const $textarea = $el.find('textarea');
    const index = $el.find('input').val();
    const tweet = $textarea.val();
    $textarea.prop('disabled', true);

    formData.tweets.push({ index, tweet });
  });
  channel.push('thread:submit', formData);
  $('#js-add-tweet').remove();
});

export default socket;
