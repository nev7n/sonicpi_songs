define :three_chord_rhythm do |c1, c2, c3, n|
  play chord( c1, :major, amp: 10)
  sleep 0.5
  
  m = n-1
  m.times do
    play chord( c1, :major)
    sleep 0.5
  end
  
  n.times do
    play chord( c2, :minor)
    sleep 0.5
  end
  
  n.times do
    play chord( c3, :major)
    sleep 0.5
  end
end

define :three_chord_aah do |c1, c2, c3|
  use_synth :growl
  play chord( c1, :major), sustain: 1.45, release: 0.05
  sleep 1.5
  play chord( c2, :minor), sustain: 1.45, release: 0.05
  sleep 1.5
  play chord( c3, :major), sustain: 1.45, release: 0.05
  sleep 1.5
end

define :main_melody do
  sleep 1.5
  play 64
  sleep 1
  play 60
  sleep 0.5
  play 59
  sleep 1.5
end

define :alt_melody do
  sleep 1.5
  play 62
  sleep 1
  play 65
  sleep 0.5
  play 67
  sleep 1.5
end

in_thread do
  use_synth :piano
  three_chord_rhythm :D5, :A, :G,3
  live_loop :rhythm do
    3.times do
      three_chord_rhythm :D5, :A, :G,3
    end
    three_chord_rhythm :D, :A, :G,3
  end
end

in_thread do
  three_chord_aah :D5, :A, :G
  live_loop :growl_rhythm do
    3.times do
      three_chord_aah :D5, :A, :G
    end
    three_chord_aah :D, :A, :G
  end
end

in_thread do
  live_loop :percussion do
    with_fx :compressor do
      sample :drum_heavy_kick, rate: 1
      sleep 0.5
      sample :drum_snare_soft, rate: 1
      sleep 0.25
      sample :bd_tek, rate: 1
      sleep 0.25
      sample :drum_heavy_kick, rate: 1
      sleep 0.5
    end
  end
end

in_thread do
  sleep 4.5
  live_loop :melody do
    with_fx :reverb do
      use_synth :piano
      2.times do
        main_melody
      end
      alt_melody
      sleep 4.5
    end
  end
end

live_loop :bass do
  use_synth :fm
  play :d2
  sleep 0.5
  play :a2
  sleep 0.5
  play :g2
  # sample :bass_hit_c
  sleep 0.5
end