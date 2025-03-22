+++
title = "Undergraduate Projects"
hasmath = false
hascode = false

date = Date(2023, 6, 17)
tags = ["blog", "undergrad", "assistive"]
+++

# Undergraduate Projects: Ankle Exoskeleton, Piano-Playing Robot, Line-Based Mapping

## Ankle Exoskeleton
~~~
<div class="row">
  <div class="container">
    <img class="right" style="width:30%;" src="/assets/blog/axo/axo.png">
    <p>
    I spent the bulk of my undergrad working on the design and control of a soft ankle exoskeleton with Maegan Tucker and Neil Janwani, advised by Aaron Ames. The key idea of the design was to use handed shearing auxetics for actuation. These compliant materials efficiently translated rotational motion (from motors) into linear actuation while remaining compiliant. Treating them as programmable springs, I designed and manufactured a compact ankle exoskeleton and tested it on several human subjects. The work resulted in a patent and made up the bulk of my undergraduate thesis. The thesis is available <a href="/assets/blog/axo/CDS_90_Senior_Thesis.pdf">here</a>.
    </p>
    <div style="clear: both"></div>      
  </div>
</div>
~~~

## Piano-Playing Robot
~~~
<div class="row">
  <div class="container">
    <img class="left" style="width:30%;" src="/assets/blog/me134/piano.jpg">
    <p>
    For ME 134 (Robot Systems) my team built a piano playing robot. We designed a 9 degree of freedom robot with two end effectors capable of playing up to two notes at a time. The emphasis was interactivity: our robot followed the piano if someone moved it around, even pulling it back into a playable region if necessary. It could teach the user to play a song, halt playing when someone got too close, and celebrate with claps and dances when it finished.
    </p>
    <div style="text-align: center;">
        <a href="https://youtu.be/PDfuBd5oUVs?si=LGZmKoJwaKKK2AUB">video</a>
        &ensp;/&ensp;
        <a href="https://github.com/CBlagden/me134">code</a>
        &ensp;/&ensp;
        <a href="/assets/blog/me134/pianoman_description.zip">ROS description</a>
    </div>
    <div style="clear: both"></div>      
  </div>
</div>
~~~

## Line-Based Mapping
~~~
<div class="row">
  <div class="container">
    <img class="right" style="width:30%;" src="/assets/blog/me169/mapping_a_box.png">
    <p>
    For ME 169, a mobile robot project class, I worked on a continuous-space mapping alogorithm using the robot's LiDAR system. Rather than work on a grid, as most SLAM algorithms do, this method stored the measured coordinates of walls as line segments in continuous space. At each time step, we converted the LiDAR point cloud into line segments using a least-squares regression. These measurement lines were combined with previously measured lines to build up a map of a space. This project was done in collaboration with <a href=https://tylerdnguyen.com/>Tyler Nguyen</a>.
    </p>
    <div style="text-align: center;">
        <a href="https://youtu.be/JQNytQPNokQ?si=uA7HYHBu3rdnZ9aP">video</a>
        &ensp;/&ensp;
        <a href="https://github.com/lopenguin/mobilerobots">code</a>
        &ensp;/&ensp;
        <a href="/assets/blog/me169/report.pdf">report</a>
    </div>
    <div style="clear: both"></div>      
  </div>
</div>
~~~