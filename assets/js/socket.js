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
  $(`#js-tweet-link-${payload.index}`).html(linkHtml);

  const total = $('.tweets-container').find('textarea').length;
  if (parseInt(payload.index, 10) === total) {
    $('#js-submit-thread').removeClass('is-loading');
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
    const index = $(el).find('input').val();
    const tweet = $(el).find('textarea').val();
    formData.tweets.push({ index, tweet });
  });
  console.log('> form:', formData);
  channel.push('thread:submit', formData);
});

export default socket;
