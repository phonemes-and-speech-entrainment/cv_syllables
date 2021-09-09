# see trial1/beggining instructions for the design of the experiment
# in the sdl part of the code, I create the arrays for feedback images, the array for the actual stimuli, and the one for the tiral stimuli
# i also create the trial types in sdl, see description above each one for details about their purpose


scenario = "Oana_syllable_experiment.sce";  
active_buttons = 1;
button_codes = 1;
target_button_codes = 1;  # button 1 = enter
response_logging= log_active;           
response_matching= simple_matching; 
randomize_trials = true;   
default_font_size= 24;
default_font = "Helvetica";
write_codes = true; 
default_cue_events = true;
default_cue_event_port = 1;
pulse_width = 10;          
begin;    

picture {} default;

bitmap { filename = "happy.jpg";} graphic1; # show when type in correct response
bitmap { filename = "sad.jpg";} graphic2; # show when typed response is incorrect

array {
LOOP $i 95; 
$k = '$i+1';
sound { wavefile { filename="$k.wav"; } ; };
ENDLOOP;
} stimuli;

array {
LOOP $i 6; 
$k = '$i+1';
sound { wavefile { filename="trial$k.wav"; } ; };
ENDLOOP;
} trialsounds;

#array {
#LOOP $i 41;
#$k = '$i +1';
#sound { wavefile { filename="filler$k.wav"; description = "$k+45";} ; };
#ENDLOOP;
#} filler;

#show this picture every time participants types in correct answer
trial {
trial_duration = 1500;
 trial_type = first_response;
  picture {
   bitmap graphic1; 
   x=0; y=0;};
   code = "right";
} pic1;


#show this picture every time wrong answer is given
trial {
trial_duration = 1500;
 trial_type = first_response;
  picture {
   bitmap graphic2; 
   x=0; y=0;};
   code = "wrong"; 
} pic2;


#show this once right in the beginning
trial {                                    
trial_duration = forever;

	 trial_type = specific_response;
    terminator_button = 1; 
stimulus_event{picture {text {caption = "The aim of this experiment is to see how the brain responds to sounds \n
beginning with different consonants.\n
There will be one practice block and five experimental blocks.\n
Each experimental block will contain 100 trials, \n
in which the sounds start with the same consonant. \n
However, some trials will contain a syllable starting with a consonant different than the rest. \n 
At the end of such trials, you will be asked to type in the sound which was different.\n
You will have a two minute break in between blocks.\n
Press ENTER to continue to the practice block. \n";}; x = 0; y = 0; }instructions; }; 
}trial1; #beginning instructions

#show this at the beginning of the practice block
trial{
trial_duration = forever;
trial_type = specific_response;
terminator_button = 1; 
stimulus_event{picture {text {caption = "This is the practice test. \n
Press Enter to continue.";}; x = 0; y = 0; }practice; }; 
} practice_trial;

#show this at the end of the practice block
trial{
trial_duration = forever;
trial_type = specific_response;
terminator_button = 1; 
stimulus_event{picture {text {caption = "This is the end of the practice test. \n
Take a few deep breaths and press Enter to continue to the main experiment.";}; x = 0; y = 0; }practicend; }; 
} practice_end;

#these are the main trials which have the same format every time an audio stimulus is presented; basically, the sound is played while participants look at a '+' sign in the middle of the screen
trial {
trial_duration = stimuli_length;  
    trial_type = first_response; 
       picture {
          text { caption = "+"; }; x = 0; y = 0;
   };
   time = 0;

	 stimulus_event {
      sound {wavefile {filename = "1.wav";};};
           time = 0;
           response_active = true;   
  } event1;
} main_trials; #play main stimuli


#show a '*' between stimuli; this is mainly to help me DC correct the EEG between trials
trial{
trial_duration = 2000;
stimulus_event{picture {text {caption = "*";}; x = 0; y = 0; }star; }; 
} inter_trial;

#show this at the end of each block of experimental trials apart from the last one
trial{
trial_duration = 20000;
stimulus_event{picture {text {caption = "Now you can take a break. \n
Feel free to move and wave at the experimenter, \n
but not too much. \n";}; x = 0; y = 0; }break; }; 
} break_trial;

#show this at the end of the last experimental block
trial{
trial_duration = forever;
	 trial_type = specific_response;
    terminator_button = 1; 
stimulus_event{picture {text {caption = "End of the experiment. \n \n
Well done!";}; x = 0; y = 0; }Endoftest; }; 
}end_trial;

#show this after a filler stimulus (defined in pcl), where one sound in the streams differs from the others; the text is also given below in pcl, and is followed by keyboard input from the participant
trial {
   stimulus_event {
       picture { text { caption = " "; } input_text; x=50; y=10;
       } input_pic;
   } input_event;
} input_trial;

begin_pcl;

# subroutine to create blocks of stimuli; this takes the indices from 3 arrays of indices from the 'stimuli' array and repeats them 10 times; also picks the indices from another array of indices from the same array of sounds, but these numbers correspond to the 'filler' stimuli; there might be a faster way to do this subroutine
sub array<int, 1> make_block (int a, int b, int e, int f, int g, int n, int c, int d, int reps) #  a = number of stimuli we want in the block, b=number of fillers we want in the block, reps = number of stimulus repetitions, c = first value to count from stimuli array, d = first value to count from in filler array
begin
 array <int> block[0];
 loop int i = 1  until i>reps begin
	 loop int j = a until j>b begin
		 block.add(j);
		 j=j+1;
	 end;
	loop int k = e until k>f begin
		block.add(k);
		k=k+1;
	end;
	loop int m = g until m>n begin
		block.add(m);
		m=m+1;
	end;
	    i=i+1;
 end;	
 loop int h = c until h>d begin
		 block.add(h);
		 h = h+1;
	 end; 
 #term.print(block);
 return block;
end;

#set description of stimulus for each block of stimuli

loop int i = 1 until i>stimuli.count() begin
	string j = "1"+string(i);
	stimuli[i].set_description(j);
	#term.print(stimuli[i].description());
	i=i+1;
end;

loop int i = 1 until i>trialsounds.count() begin
	string j = "2"+string(i);
	trialsounds[i].set_description(j);
	i=i+1;
end;

#create trial block


array<int> blockt[0];

loop int i=1 until i>trialsounds.count() begin
	blockt.add(i);
	i=i+1;
end;


#create array of indices for target stimuli, they come in triplets because there are three different sounds containing the same consonant, and I want them all played in one block of trials
array <int> index1[15][2]={{1,3},{4,6},{7,9},{10,12},{13,15},{16,18},{19,21},{22,24},{25,27},{28,30},{31,33},{34,36},{37,39},{40,42},{43,45}};

#create array of indices for 'filler' stimuli, these need to be 10% of the total number of stimuli in one block, so if we add 9 main sounds, then repeat them 10 times, then we need to add 10 more 'filler' stimuli to each block
array <int> index2[5][2]={{46,55},{56,65},{66,75},{76,85},{86,95}};

index1.shuffle();
index2.shuffle();

int num_reps = 10;

#create blocks of indices using make_block subroutine
array<int> block1[100]=make_block(index1[1][1],index1[1][2],index1[2][1],index1[2][2],index1[3][1],index1[3][2],index2[1][1],index2[1][2],num_reps);
array<int> block2[100]=make_block(index1[4][1],index1[4][2],index1[5][1],index1[5][2],index1[6][1],index1[6][2],index2[2][1],index2[2][2],num_reps);
array<int> block3[100]=make_block(index1[7][1],index1[7][2],index1[8][1],index1[8][2],index1[9][1],index1[9][2],index2[3][1],index2[3][2],num_reps);
array<int> block4[100]=make_block(index1[10][1],index1[10][2],index1[11][1],index1[11][2],index1[12][1],index1[12][2],index2[4][1],index2[4][2],num_reps);
array<int> block5[100]=make_block(index1[13][1],index1[13][2],index1[14][1],index1[14][2],index1[15][1],index1[15][2],index2[5][1],index2[5][2],num_reps);



#create list of correct responses after 'filler' stimuli are presented, in the main trials
array<string> expected_response[50] = {"zoo", "no", "te", "do", "zo", "mo", "zo", "ke", "do", "ga", "mo", "le", "pa", "fa", "ro", "re", "ge", "noo", "kee", "tee", "dee", "too", "bo", "se", "noo", "noo", "boo", "ta", "lo", "ra","ro", "se", "ga", "moo", "too", "sa", "go", "se", "fa", "re", "soo", "bee", "foo", "foo", "soo", "zo", "sa", "be", "fe", "pa"};

#create list of correct responses after 'filler' stimuli are presented, in the practice trials
array<string> expected_trial[3] = {"go","ka","doo"};


# main experiment

#shuffle indices in each block
blockt.shuffle();
block1.shuffle(); 
#term.print(block1);
block2.shuffle();
#term.print(block2);
block3.shuffle();
#term.print(block3);
block4.shuffle();
#term.print(block4);
block5.shuffle();
#term.print(block5);


# subroutine to present the actual sounds, add the question after each 'filler' sound and allow for keyboard input

sub present_block (array <int> block[100])
begin
	#term.print(block);
	loop int i = 1 until i>block.count() begin
       int b = block[i];
       string code = stimuli[b].description();
       int port_code = int(code);
       event1.set_stimulus(stimuli[b]);
       event1.set_event_code( code );
       event1.set_port_code( port_code );
       main_trials.present();
   if (port_code>145) then
      system_keyboard.set_max_length (1);
      string caption = "What was the different sound? Type it in followed by Enter";
      input_text.set_caption( caption );
      input_text.redraw();
      input_trial.present();
      caption = system_keyboard.get_input();
      loop until system_keyboard.last_input_type() == keyboard_delimiter
      begin
        input_text.set_caption( caption );
        input_text.redraw();
        input_trial.present();
        caption = caption + system_keyboard.get_input();
        end;
        if (system_keyboard.last_input_type() == keyboard_delimiter) then
	     if (caption == expected_response[b-45]) then  
        pic1.present();
        else
        pic2.present();
        end;
        end;
      end;
   inter_trial.present();
   i=i+1;
end;
end;

# present practice block, using method described above but not using the subroutine (there was a reason for it that didn't have to do with just the numbers of stimuli that differ between the practice and the main trials, but I can't remember which one it was; I might have just gotten lazy too)

trial1.present();
practice_trial.present();
#present trials
loop int i = 1 until i>blockt.count() begin
       string code1 = trialsounds[blockt[i]].description();
       int port_code1 = int(code1);
		 event1.set_stimulus(trialsounds[blockt[i]]);
       event1.set_event_code( code1 );
       event1.set_port_code( port_code1 );
       main_trials.present();
   if (port_code1>23) then
	   #term.print(port_code);
      system_keyboard.set_max_length (1);
      string caption = "What was the different sound? Type it in followed by Enter";
      input_text.set_caption( caption );
      input_text.redraw();
      input_trial.present();
      caption = system_keyboard.get_input();
      loop until system_keyboard.last_input_type() == keyboard_delimiter
      begin
        input_text.set_caption( caption );
        input_text.redraw();
        input_trial.present();
        caption = caption + system_keyboard.get_input();
        end;
        if (system_keyboard.last_input_type() == keyboard_delimiter) then
	     if (caption == expected_trial[blockt[i]-3]) then  
        pic1.present();
        else
        pic2.present();
        end;
        end;
      end;
   inter_trial.present();
   i=i+1;
end;

#present all trials and blocks of stimuli using the present_block routine
practice_end.present();
present_block(block1);
break_trial.present();
present_block(block2);
break_trial.present();
present_block(block3);
break_trial.present();
present_block(block4);
break_trial.present();
present_block(block5);




end_trial.present();


