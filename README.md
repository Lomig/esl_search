# README
_new_lesson_form:

      <%= f.input :lesson_start, as: :time, label: "start" %>

@consultation.consult_freq << consultation_params[:consult_freq]
consultation_params[:consult_freq]
<!-- for issues with server :
  kill -9 $(lsof -i tcp:3000 -t)
-->

<% @consultations.each do |c| %>
      <% @consultation_review_star = c.reviews.all.map{|x| [x.star]} %>
      <% if @consultation_review_star!= [] %>
        <% @review_stars = @consultation_review_star.sum %>
      <!-- ^ @total_review_stars produces single array ex: [4,2] not sure why -->
      <% @total_review_stars = @review_stars.sum %>
       <!-- ^ SAME as above: @total_review_stars = @review_stars.inject(0){|sum,x| sum + x } -->
       <!-- ^^ sum of all stars ex[4 + 1] = 5 -->
      <% @total_reviews = @consultation_review_star.size %>
       <!-- ^ total number of reviews with stars ex: 2 -->
      <% @avg_star = (@total_review_stars / @total_reviews) %>
      <% else %>
      <% end %>
      <% end %>



This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

<!-- <%= f.input :consult_native_speaker, label: "native speaker?", as: :radio_buttons, collection: [['yes','yes'],['no','no']], label_method: :second, value_method: :first, checked: ['yes','yes']%> -->

<!-- $( document ).ready(function() {
  $('input[type=radio]').on('change',function() {
    $('input[name=name_of_your_radiobutton]:checked').val();
  });
}); -->

<!-- Oct 31
$( document ).ready(function() {
  $('input[type=radio]').on('change',function() {
    if( $(this).is(':checked') ) {
          $('.instructor-registration').eq( $('input[type=radio]').index( this ) ).show();
    } else {
          $('.instructor-registration').eq( $('input[type=radio]').index( this ) ).hide();
    }
  });
}); -->


May 7, color scheme
<!-- https://coolors.co/84afff-048ba8-16db93-efea5a-f29e4c -->

<!-- #84AFFF -->
<!-- #048BA8 -->
<!-- #16DB93 -->
<!-- #EFEA5A -->
<!-- #F29E4C -->
------------------

<!-- new set below:
rgb
rgb(132, 175, 255)
rgb(151, 132, 255)
rgb(212, 132, 255)
rgb(255, 132, 237)
rgb(255, 132, 175)
rgb(255, 151, 132)

SCSS
$color-1: #84afff;
$color-2: #9784ff;
$color-3: #d484ff;
$color-4: #ff84ed;
$color-5: #ff84af;
$color-6: #ff9784; -->



April 17

 <!--  <% @consultations.each do |c|%>
        <% c.appointments.last(3).each do |a| %>
          <%= link_to user_path(a.user.id), class: "no-decor" do %>
            <div class="dashboard-clients-list-div">
              <div class="shell-tab flex-space-between dashbaoard-client-list-items">
                <div class="client-item">
                  <% avatar_url = a.user.photo.url(:bright_face) || avatar_url = "https://res.cloudinary.com/mattg/image/upload/v1494130069/user-icon_arl6kj.png" %>
                  <!-- ^ added `.url(:brightface)` from the `photo_uploader` class-->
                <div class="user-sm-profile-image-img icon-shell icon-shell" style="background-image: url('<%= image_path avatar_url %>'); background-size: cover;  height: 50px; width: 50px; border-radius: 50%; background-position: center;"></div>
                </div><!--end of icon-div-->
                <div class="client-item"><%= a.user.fname %></div><!--end of client-item-->
              </div><!--end of shell-tab dashbaoard-client-list-items-->
            </div><!--end dashboard-clients-list-div-->
          <% end %><!--end of link_to user_path-->
        <% end %><!--end c.appointments-->
      <% end %><!--end current_user.consultations.last--> -->

<% avatar_url = client.photo.url(:bright_face) || avatar_url = "https://res.cloudinary.com/mattg/image/upload/v1494130069/user-icon_arl6kj.png" %>


<div class="dashboard-consults-shell shell-border">
    <div class="dashboard-consult header-items">
      <div class="consult-header-item"><h4 class="dashboard-consults-header">Consultations</h4></div>
      <div class="consult-header-item counter"><%= @my_cons_appointments_array.size %></div>
    </div><!--end of dashboard-consult header-items-->
    <div class="dashboard-consults-div">
      <% @consultations.each do |c| %>
        <% c.appointments.last(1).each do |a| %>
          <%= link_to appointment_path(a) do %>
            <div class="flex-space-between shell-tab">
              <div class="consult-item">
                <% avatar_url = a.user.photo.url(:bright_face) || avatar_url = "https://res.cloudinary.com/mattg/image/upload/v1494130069/user-icon_arl6kj.png" %>
                <!-- ^ added `.url(:brightface)` from the `photo_uploader` class-->
                <div class="user-sm-profile-image-img icon-shell icon-shell" style="background-image: url('<%= image_path avatar_url %>'); background-size: cover;  height: 50px; width: 50px; border-radius: 50%; background-position: center;"></div>
              </div><!--end of icon-div-->
              <div class="consult-item"><%= a.start.strftime('%m/%d/%Y at %I:%M%p')%></div>
            </div><!--end of shell-tab-->
          <% end %><!--end link_to-->
        <% end %><!--end c.appointments.each-->
      <% end %><!-- end @consultations.each-->
    </div><!--end dashboard-consults-div-->
  </div><!-- end dashboard-consults-shell-->
