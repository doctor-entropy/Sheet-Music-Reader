file_name = input('Which file do you want to read? \n','s')
I = imread(file_name);
k = 15
c_c = 100;
if(strcmp(file_name, 'otj1.jpg'))
    k = 10;
    c_c = 35
end

if (strcmp(file_name, 'simple_2.jpg'))
    w = load('simple_2/w.mat');
    w = struct2array(w);
    w_whole = load('simple_2/w_whole.mat');
    w_whole = struct2array(w_whole);
    w_treb = load('simple_2/w_treb.mat');
    w_treb = struct2array(w_treb);
    w_bass = load('simple_2/w_bass.mat');
    w_bass = struct2array(w_bass);
end

if (strcmp(file_name, 'simple.jpg'))
    w = load('simple_1/w.mat');
    w = struct2array(w);
    %w_whole = 
    %w_whole = struct2array(w_whole);
    w_treb = load('simple_1/w_treb.mat');
    w_treb = struct2array(w_treb);
    w_bass = load('simple_1/w_bass.mat');
    w_bass = struct2array(w_bass);
end

if (strcmp(file_name, 'otj1.jpg'))
    w = load('otj/w.mat');
    w = struct2array(w);
    w_half = load('otj/w_half.mat');
    w_half = struct2array(w_half);
    w_treb = load('otj/w_treb.mat');
    w_treb = struct2array(w_treb);
    w_sharps = load('otj/w_sharps.mat');
    w_sharps = struct2array(w_sharps);
end
S = strel('line', 100, 0);
S_15 = strel('line', c_c, k);
S_173 = strel('line', 100, 173);
I = im2bw(I, 0.4);
size_sheet = size(I);

W = imclose(I, S);
[LW, numWhite] = bwlabel(~W);
figure, imshow(~W);

line_regions = regionprops(LW);

W_15 = imclose(I, S_15);
[LW_15, numWhite] = bwlabel(~W_15);
figure, imshow(~W_15);

W_173 = imclose(I, S_173);
[LW_173, numWhite] = bwlabel(~W_173);
figure, imshow(~W_173);

eighth_notes_15 = regionprops(LW_15);
eighth_notes_173 = regionprops(LW_173);

if exist('w') == 0
    [w, rect] = imcrop(I); %Crops the required region/letter
    imshow(w);
end
C = normxcorr2(w,I); %Performs normalized cross-correlation
C(C > 0.6) = 1; %Thresholding the C score
imshow(C);

B = im2bw(C, 0.80); %Converts the C image into Black-White image, the template 'w' is the threshold
imshow(B);

L = bwlabel(B); %Performs connected component labelling
notes_region = regionprops(L); %assigns bounding box and centroid for each match
notes = [];

if exist ('w_whole') == 0
    [w_whole, rect_whole] = imcrop(I); %Crops the required region/letter
    %imshow(w_whole);
end

if exist('w_treb') == 0
    [w_treb, rect] = imcrop(I); %Crops the required region/letter
    %imshow(w_treb);
end

if exist('w_bass') == 0
    [w_bass, rect] = imcrop(I); %Crops the required region/letter
    %imshow(w_bass);
end

if exist('w_sharps') == 0
    [w_sharps, rect] = imcrop(I); %Crops the required region/letter
    imshow(w_sharps);
end

if exist('w_flats') == 0
    [w_flats, rect] = imcrop(I); %Crops the required region/letter
    imshow(w_flats);
end

size_treb = size(w_treb);
size_bass = size(w_bass);

C_treb = normxcorr2(w_treb,I); %Performs normalized cross-correlation
C_treb(C_treb > 0.99) = 1; %Thresholding the C score
%imshow(C_treb);
B_treb = im2bw(C_treb, 0.80); %Converts the C image into Black-White image, the template 'w' is the threshold
%imshow(B_treb);
L_treb = bwlabel(B_treb); %Performs connected component labelling
t_cleft_regions = regionprops(L_treb); %assigns bounding box and centroid for each match
C_treb = normxcorr2(w_treb,I); %Performs normalized cross-correlation
C_treb(C_treb > 0.99) = 1; %Thresholding the C score
%imshow(C_treb);

try
    C_bass = normxcorr2(w_bass,I); %Performs normalized cross-correlation
    C_bass(C_bass > 0.99) = 1; %Thresholding the C score
    %imshow(C_bass);
    B_bass = im2bw(C_bass, 0.80); %Converts the C image into Black-White image, the template 'w' is the threshold
    %imshow(B_bass);
    L_bass = bwlabel(B_bass); %Performs connected component labelling
    b_cleft_regions = regionprops(L_bass); %assigns bounding box and centroid for each match
catch
    
end
try
    C_whole = normxcorr2(w_whole,I); %Performs normalized cross-correlation
    C_whole(C_whole > 0.6) = 1; %Thresholding the C score
    B_whole = im2bw(C_whole, 0.80); %Converts the C image into Black-White image, the template 'w' is the threshold
    imshow(B_whole);
    L_whole = bwlabel(B_whole);
    notes_whole = regionprops(L_whole);
    figure, imshow(I);
catch
    ;
%imshow(C_whole);
end

try
    C_half = normxcorr2(w_half,I); %Performs normalized cross-correlation
    C_half(C_half > 0.6) = 1; %Thresholding the C score
    %imshow(C_bass);
    B_half = im2bw(C_half, 0.80); %Converts the C image into Black-White image, the template 'w' is the threshold
    %imshow(B_bass);
    L_half = bwlabel(B_half); %Performs connected component labelling
    notes_half = regionprops(L_half); %assigns bounding box and centroid for each match
catch
    
end

try
    C_sharps = normxcorr2(w_sharps,I); %Performs normalized cross-correlation
    C_sharps(C_sharps > 0.6) = 1; %Thresholding the C score
    imshow(C_sharps);
    
    B_sharps = im2bw(C_sharps, 0.80); %Converts the C image into Black-White image, the template 'w' is the threshold
    imshow(B_sharps);
    
    L_sharps = bwlabel(B_sharps); %Performs connected component labelling
    sharps_regions = regionprops(L_sharps); %assigns bounding box and centroid for each match
catch
    
end

try
    C_flats = normxcorr2(w_flats,I); %Performs normalized cross-correlation
    C_flats(C_flats > 0.6) = 1; %Thresholding the C score
    imshow(C_flats);
    
    B_flats = im2bw(C_flats, 0.80); %Converts the C image into Black-White image, the template 'w' is the threshold
    imshow(B_flats);
    
    L_flats = bwlabel(B_flats); %Performs connected component labelling
    flats_regions = regionprops(L_flats); %assigns bounding box and centroid for each match
catch
    
end

figure, imshow(I);
t_cleft_bounding_box = [];
for i=1:length(t_cleft_regions)
    % Draw a rectangle around each match, the next 4 lines are to correct
    % the boxes' enclosure
    t_cleft_regions(i).BoundingBox(1) = line_regions((i*5) - 4).BoundingBox(1);
    t_cleft_regions(i).BoundingBox(2) = t_cleft_regions(i).BoundingBox(2) - size_treb(1,2)*2.3;
    t_cleft_regions(i).BoundingBox(3) = line_regions((i*5) - 4).BoundingBox(3);
    t_cleft_regions(i).BoundingBox(4) = t_cleft_regions(i).BoundingBox(4) + size_treb(1,1)*0.99;
    t_cleft_bounding_box = [t_cleft_bounding_box; t_cleft_regions(i).BoundingBox];
    rectangle('Position', t_cleft_regions(i).BoundingBox, 'EdgeColor', 'g', 'LineWidth', 3);
    %c = t_cleft_regions(i).Centroid;
end
sorted_tcleft = sortrows(t_cleft_bounding_box, 2);
b_cleft_bounding_box = [];
try
    for i=1:length(b_cleft_regions)
        % Draw a rectangle around each match, the next 4 lines are to correct
        % the boxes' enclosure
        b_cleft_regions(i).BoundingBox(1) = b_cleft_regions(i).BoundingBox(1) - size_bass(1,1)*0.70;
        b_cleft_regions(i).BoundingBox(2) = b_cleft_regions(i).BoundingBox(2) - size_bass(1,2)*1.9;
        b_cleft_regions(i).BoundingBox(3) = b_cleft_regions(i).BoundingBox(3) + size_sheet(1,2)*0.88;
        b_cleft_regions(i).BoundingBox(4) = b_cleft_regions(i).BoundingBox(4) + size_bass(1,1)*1.2;
        b_cleft_bounding_box = [b_cleft_bounding_box; b_cleft_regions(i).BoundingBox];
        rectangle('Position', b_cleft_regions(i).BoundingBox, 'EdgeColor', 'c', 'LineWidth', 3);
        %c = b_cleft_regions(i).Centroid;
    end
catch
    
end
try
sorted_bcleft = sortrows(b_cleft_bounding_box, 2);
catch
end


staves = [];
for i=1:length(line_regions)
    % Draw a rectangle around each match, the next 4 lines are to correct
    % the boxes' enclosure
    line_regions(i).BoundingBox(1) = line_regions(i).BoundingBox(1);
    line_regions(i).BoundingBox(2) = line_regions(i).BoundingBox(2);
    line_regions(i).BoundingBox(3) = line_regions(i).BoundingBox(3);
    line_regions(i).BoundingBox(4) = line_regions(i).BoundingBox(4);
    rectangle('Position', line_regions(i).BoundingBox, 'EdgeColor', 'r');
    c = line_regions(i).Centroid;
    staves = [staves, line_regions(i).Centroid(2)];
    disp(c);
    line([c(1)-5 c(1)+5], [c(2) c(2)], 'Color', 'y');
    line([c(1) c(1)], [c(2)-5 c(2)+5], 'Color', 'y');
end

diff = (line_regions(3).Centroid(2) - line_regions(2).Centroid(2))*0.98;

notes_test = [];
for i=1:length(notes_region)
    % Draw a rectangle around each match, the next 4 lines are to correct
    % the boxes' enclosure
    notes_region(i).BoundingBox(1) = notes_region(i).BoundingBox(1) - diff;
    notes_region(i).BoundingBox(2) = notes_region(i).BoundingBox(2) - diff;
    notes_region(i).BoundingBox(3) = notes_region(i).BoundingBox(3) + diff;
    notes_region(i).BoundingBox(4) = notes_region(i).BoundingBox(4) + diff;
    rectangle('Position', notes_region(i).BoundingBox, 'EdgeColor', 'g');
    c = notes_region(i).Centroid - ((diff/2)*1.2);
    %c = notes_region(i).Centroid
    notes = [notes; c, 1];
    disp(c);
    line([c(1)-5 c(1)+5], [c(2) c(2)], 'Color', 'y');
    line([c(1) c(1)], [c(2)-5 c(2)+5], 'Color', 'y');
    notes_test = [notes_test; c(1), c(2),1];
end

try
    for i=1:length(notes_whole)
        % Draw a rectangle around each match, the next 4 lines are to correct
        % the boxes' enclosure
        notes_whole(i).BoundingBox(1) = notes_whole(i).BoundingBox(1) - diff;
        notes_whole(i).BoundingBox(2) = notes_whole(i).BoundingBox(2) - diff;
        notes_whole(i).BoundingBox(3) = notes_whole(i).BoundingBox(3) + diff;
        notes_whole(i).BoundingBox(4) = notes_whole(i).BoundingBox(4) + diff;
        rectangle('Position', notes_whole(i).BoundingBox, 'EdgeColor', 'b');
        c = notes_whole(i).Centroid - ((diff/2)*1.2);
        notes = [notes; c, 4];
        notes_test = [notes_test; c(1), c(2), 4];
        disp(c);
        line([c(1)-5 c(1)+5], [c(2) c(2)], 'Color', 'y');
        line([c(1) c(1)], [c(2)-5 c(2)+5], 'Color', 'y');
    end
catch
    ;
end

try
    for i=1:length(notes_half)
        % Draw a rectangle around each match, the next 4 lines are to correct
        % the boxes' enclosure
        notes_half(i).BoundingBox(1) = notes_half(i).BoundingBox(1) - diff;
        notes_half(i).BoundingBox(2) = notes_half(i).BoundingBox(2) - diff;
        notes_half(i).BoundingBox(3) = notes_half(i).BoundingBox(3) + diff;
        notes_half(i).BoundingBox(4) = notes_half(i).BoundingBox(4) + diff;
        rectangle('Position', notes_half(i).BoundingBox, 'EdgeColor', 'b');
        c = notes_half(i).Centroid - ((diff/2)*1.2);
        notes = [notes; c, 2];
        notes_test = [notes_test; c(1), c(2), 2];
        disp(c);
        line([c(1)-5 c(1)+5], [c(2) c(2)], 'Color', 'y');
        line([c(1) c(1)], [c(2)-5 c(2)+5], 'Color', 'y');
    end
catch
    ;
end

for i=1:length(eighth_notes_15)
    % Draw a rectangle around each match, the next 4 lines are to correct
    % the boxes' enclosure
    eighth_notes_15(i).BoundingBox(1) = eighth_notes_15(i).BoundingBox(1)*0.98;
    eighth_notes_15(i).BoundingBox(2) = eighth_notes_15(i).BoundingBox(2);
    eighth_notes_15(i).BoundingBox(3) = eighth_notes_15(i).BoundingBox(3)*1.8;
    eighth_notes_15(i).BoundingBox(4) = 120;
    rectangle('Position', eighth_notes_15(i).BoundingBox, 'EdgeColor', 'm', 'LineWidth',2);
    for j=1:length(notes_test)
        if(notes(j,1) >= eighth_notes_15(i).BoundingBox(1) ...
                && notes(j,1) <= (eighth_notes_15(i).BoundingBox(1)+ eighth_notes_15(i).BoundingBox(3)) ...
                && notes(j,2) >= eighth_notes_15(i).BoundingBox(2) ...
                && notes(j,2) <= (eighth_notes_15(i).BoundingBox(2)+ eighth_notes_15(i).BoundingBox(4)))
            notes(j,3) = 0.5;
            notes_test(j,3) = 0.5;
        end
    end
end

for i=1:length(eighth_notes_173)
    % Draw a rectangle around each match, the next 4 lines are to correct
    % the boxes' enclosure
    eighth_notes_173(i).BoundingBox(1) = eighth_notes_173(i).BoundingBox(1)*0.97;
    eighth_notes_173(i).BoundingBox(2) = eighth_notes_173(i).BoundingBox(2);
    eighth_notes_173(i).BoundingBox(3) = eighth_notes_173(i).BoundingBox(3)*1.20;
    eighth_notes_173(i).BoundingBox(4) = 120;
    rectangle('Position', eighth_notes_173(i).BoundingBox, 'EdgeColor', 'm', 'LineWidth',2);
    for j=1:length(notes_test)
        if(notes(j,1) >= eighth_notes_173(i).BoundingBox(1) ...
                && notes(j,1) <= (eighth_notes_173(i).BoundingBox(1)+ eighth_notes_173(i).BoundingBox(3)) ...
                && notes(j,2) >= eighth_notes_173(i).BoundingBox(2) ...
                && notes(j,2) <= (eighth_notes_173(i).BoundingBox(2)+ eighth_notes_173(i).BoundingBox(4)))
            notes(j,3) = 0.5;
            notes_test(j,3) = 0.5;
        end
    end
end

staves_sorted = sortrows(staves', 1);

notes_treble = [];
notes_bass = [];
for i=1:size(sorted_tcleft, 1)
    for j=1:length(notes)
        if((notes(j,1)>= sorted_tcleft(i,1))&&...
                (notes(j,1)<= sorted_tcleft(i,1) + sorted_tcleft(i,3))&&...
                (notes(j,2)>= sorted_tcleft(i,2))&&...
                (notes(j,2)<= sorted_tcleft(i,2) + sorted_tcleft(i,4)))
                notes_treble = [notes_treble; notes(j,1) + (size_sheet(2)*(i-1)*1.5), notes(j,2), notes(j,3)];
                disp(notes(j,2));
        end
        try
        if((notes(j,1)>= b_cleft_regions(i).BoundingBox(1))&&...
                (notes(j,1)<= b_cleft_regions(i).BoundingBox(1)+b_cleft_regions(i).BoundingBox(3))...
                &&(notes(j,2)>= b_cleft_regions(i).BoundingBox(2))&&...
                (notes(j,2)<= b_cleft_regions(i).BoundingBox(2)+b_cleft_regions(i).BoundingBox(4)))
                notes_bass = [notes_bass; notes(j,1) + size_sheet(2)*(i-1)*1.5, notes(j,2), notes(j,3)];
        end
        catch
            
        end
    end
end

sharps = [];
try
    for i=1:length(sharps_regions)
        % Draw a rectangle around each match, the next 4 lines are to correct
        % the boxes' enclosure
        %     sharps_regions(i).BoundingBox(1) = sharps_regions(i).BoundingBox(1);
        %     sharps_regions(i).BoundingBox(2) = sharps_regions(i).BoundingBox(2) - ((diff)*1.5);
        %     sharps_regions(i).BoundingBox(3) = sharps_regions(i).BoundingBox(3);
        %     sharps_regions(i).BoundingBox(4) = sharps_regions(i).BoundingBox(4);
        %     rectangle('Position', sharps_regions(i).BoundingBox, 'EdgeColor', 'r');
        c(1) = sharps_regions(i).Centroid(1);
        c(2) = sharps_regions(i).Centroid(2) - ((diff)*1.5);
        if(c(2) <= staves_sorted(5))
            sharps = [sharps; c(1), c(2)];
        end
        disp(c);
        line([c(1)-10 c(1)+10], [c(2) c(2)], 'Color', 'b');
        line([c(1) c(1)], [c(2)-10 c(2)+10], 'Color', 'b');
    end
    
catch
end

flats = [];
try
    for i=1:length(flats_regions)
        % Draw a rectangle around each match, the next 4 lines are to correct
        % the boxes' enclosure
        %     sharps_regions(i).BoundingBox(1) = sharps_regions(i).BoundingBox(1);
        %     sharps_regions(i).BoundingBox(2) = sharps_regions(i).BoundingBox(2) - ((diff)*1.5);
        %     sharps_regions(i).BoundingBox(3) = sharps_regions(i).BoundingBox(3);
        %     sharps_regions(i).BoundingBox(4) = sharps_regions(i).BoundingBox(4);
        %     rectangle('Position', sharps_regions(i).BoundingBox, 'EdgeColor', 'r');
        c(1) = flats_regions(i).Centroid(1);
        c(2) = flats_regions(i).Centroid(2) - ((diff)*1.5);
        if(c(2) <= staves_sorted(5))
            flats = [flats; c(1), c(2)];
        end
        %disp(c);
        line([c(1)-10 c(1)+10], [c(2) c(2)], 'Color', 'b');
        line([c(1) c(1)], [c(2)-10 c(2)+10], 'Color', 'b');
    end
    
catch
end

sorted_tn = sortrows(notes_treble, 1);
notes_sorted = sortrows(notes, 1);
try
sorted_bass = sortrows(notes_bass, 1);
catch
end
% notes_test_sorted = sortrows(notes_test, 1);
% notes_1 = [];

% for i=1:length(notes_sorted(:,1))
%     if (notes_sorted(i,2) < (line_regions(5).Centroid(2)*2))
%         disp(notes_sorted(i,:))
%         notes_1 = [notes_1; notes_sorted(i,:)];
%     end
% end

t = (diff/4);
[play_back, play_back_actual] = get_notes(staves_sorted, sorted_tcleft,sorted_tn, diff, t);
try
[play_back_bass, play_back_actual_bass] = get_notes_bass(staves_sorted, sorted_bcleft,sorted_bass, diff, t);
catch
end

[which_sharps, which_sharps_actual] = get_notes(staves_sorted, sorted_tcleft,sharps, diff, t);
[which_flats, which_flats_actual] = get_notes(staves_sorted, sorted_tcleft,flats, diff, t);

if(sum(ismember([4,5,6,7,8,9,10], which_flats)) == 7)
    scale = 'C-flat major/A-flat minor';
elseif(sum(ismember([5,6,7,8,9,10], which_flats)) == 6)
    scale = 'G-flat major/E-flat minor';
elseif(sum(ismember([5,6,7,9,10], which_flats)) == 5)
    scale = 'D-flat major/B-flat minor';
elseif(sum(ismember([6,7,9,10], which_flats)) == 4)
    scale = 'A-flat major/F minor';
elseif(sum(ismember([6,7,10], which_flats)) == 3)
    scale = 'E-flat major/C minor';
elseif(sum(ismember([7,10], which_flats)) == 2)
    scale = 'B-flat major/G minor';
elseif(sum(ismember(7, which_flats)) == 1)
    scale = 'F major/D minor';
elseif(sum(ismember([6,7,8,9,10,11,12], which_sharps)) == 7)
    scale = 'C# major/A# minor';
elseif(sum(ismember([6,8,9,10,11,12], which_sharps)) == 6)
    scale = 'F# major/D# minor';
elseif(sum(ismember([6,8,9,11,12], which_sharps)) == 5)
    scale = 'B major/G# minor';
elseif(sum(ismember([8,9,11,12], which_sharps)) == 4)
    scale = 'E major/C# minor';
elseif(sum(ismember([8,11,12], which_sharps)) == 3)
    scale = 'A major/F# minor';
elseif(sum(ismember([8,11], which_sharps)) == 2)
    scale = 'D major/B minor';
elseif(sum(ismember(11, which_sharps)) == 1)
    scale = 'G major/E minor';
elseif(isempty(which_sharps))
    scale = 'C major/A minor';
end

diff_2clefts = (staves_sorted(6) - staves_sorted(5))/2;

text_position = [];

for h=1:size(sorted_tcleft, 1)
    for i=1:length(play_back)  
        if(sorted_tn(i,2) <= staves_sorted(5*h)+diff_2clefts && ...
                sorted_tn(i,2) >= sorted_tcleft(h, 2))
            text_position = [text_position; sorted_tn(i,1) - (size_sheet(2)*(h-1)*1.5), ...
                staves_sorted(h*5)+diff_2clefts];
        end
    end
end

text(40, 40, ...
        scale, 'FontSize', 30, 'Color', 'black');

for i=1:length(play_back)
    
    text(text_position(i,1), text_position(i,2), ...
        play_back_actual(i, :), 'FontSize', 20, 'Color', 'red');
    try
    text(text_position(i,1), text_position(i,2) + 250, ...
        play_back_actual_bass(i, :), 'FontSize', 20, 'Color', 'red');
    catch
    end
    
    if(sorted_tn(i, 3) == 1)
        mul = 1;
    elseif(sorted_tn(i,3) == 0.5)
        mul = 0.5;
    elseif(sorted_tn(i,3) == 2)
        mul= 2;
    elseif(sorted_tn(i,3) == 4)
        mul= 4;
    end
    
    tempo_sec = 0.5;
    
    Fs = 40000;
    Ts=1/Fs;
    tt= [0:Ts:(tempo_sec*mul)];
    
    if(play_back(i) == 1)
        F_A = 261.63;
    end
    if(play_back(i) == 2)
        F_A = 293.66;
    end
    if(play_back(i) == 3)
        F_A = 329.63;
    end
    if(play_back(i) == 4)
        F_A = 349.23;
    end
    if(play_back(i) == 5)
        F_A = 392.00;
    end
    if(play_back(i) == 6)
        F_A = 440.00;
    end
    if(play_back(i) == 7)
        F_A = 493.88;
    end
    if(play_back(i) == 8)
        F_A = 523.25;
    end
    if(play_back(i) == 9)
        F_A = 587.33;
    end
    if(play_back(i) == 10)
        F_A = 659.25;
    end
    if(play_back(i) == 11)
        F_A = 698.46;
    end
    if(play_back(i) == 12)
        F_A = 783.99;
    end
    %
    try
    if(play_back_bass(i) == 21)
        F_A_B = 41.20;
    end
    if(play_back_bass(i) == 22)
        F_A_B = 43.65;
    end
    if(play_back_bass(i) == 23)
        F_A_B = 49.00;
    end
    if(play_back_bass(i) == 24)
        F_A_B = 55.00;
    end
    if(play_back_bass(i) == 25)
        F_A_B = 61.74;
    end
    if(play_back_bass(i) == 26)
        F_A_B = 65.41;
    end
    if(play_back_bass(i) == 27)
        F_A_B = 73.42;
    end
    if(play_back_bass(i) == 28)
        F_A_B = 82.41;
    end
    if(play_back_bass(i) == 29)
        F_A_B = 87.31;
    end
    if(play_back_bass(i) == 30)
        F_A_B = 98.00;
    end
    if(play_back_bass(i) == 31)
        F_A_B = 110.00;
    end
    if(play_back_bass(i) == 32)
        F_A_B = 123.47;
    end
    if(play_back_bass(i) == 33)
        F_A_B = 130.81;
    end
    catch
    end
    
    if(strcmp(scale, 'D major/B minor'))
        if(play_back(i) == 4)
            F_A = 369.99;
        end
        if(play_back(i) == 1)
            F_A = 277.18;
        end
        if(play_back(i) == 11)
            F_A = 739.99;
        end
        if(play_back(i) == 11)
            F_A = 739.99;
        end
        if(play_back(i) == 8)
            F_A = 554.37;
        end
    end
    
    A= 1.05*sin(2*pi*F_A*tt);
    
    if(~isempty(notes_bass))
        A_B= 1.05*sin(2*pi*F_A_B*2*tt);
    end
    sound(A,Fs);
    if(~isempty(notes_bass))
        sound(A_B, Fs);
    end
    pause((tempo_sec)+0.02);
    
end

% text(25, 530, ...
%         'WISHING ALL OF YOU...', 'FontSize', 70, 'Color', 'blue');
% text(25, 700, ...
%         'Love, Joy and Happiness!', 'FontSize', 60, 'Color', 'blue');


function [play_back, play_back_actual] = get_notes(staves_sorted, sorted_tcleft, sorted_tn, diff, t)
play_back = [];
play_back_actual = [];
for h=1:size(sorted_tcleft, 1)
    for i=1:length(sorted_tn)
        
        if (sorted_tn(i,2) >= (staves_sorted(5 + (h-1)*5) + 1*diff - t)...
                && sorted_tn(i,2) <= (staves_sorted(5 + (h-1)*5) + 1*diff + t))
            disp('c_l')
            play_back = [play_back; 1];
            play_back_actual = [play_back_actual; 'c_3'];
        end
        if (sorted_tn(i,2) >= (staves_sorted(5 + (h-1)*5) + 0.5*diff - t) ...
                && sorted_tn(i,2) <= (staves_sorted(5 + (h-1)*5) + 0.5*diff + t))
            disp('d_l')
            play_back = [play_back; 2];
            play_back_actual = [play_back_actual; 'd_3'];
        end
        if (sorted_tn(i,2) >= (staves_sorted(5 + (h-1)*5) - t) &&...
                sorted_tn(i,2) <= (staves_sorted(5 + (h-1)*5) + t))
            disp('e_l')
            play_back = [play_back; 3];
            play_back_actual = [play_back_actual; 'e_3'];
        end
        if (sorted_tn(i,2) >= (staves_sorted(5 + (h-1)*5) - 0.5*diff - t) &&...
                sorted_tn(i,2) <= (staves_sorted(5 + (h-1)*5) - 0.5*diff + t))
            disp('f_l')
            play_back = [play_back; 4];
            play_back_actual = [play_back_actual; 'f_3'];
        end
        if (sorted_tn(i,2) >= (staves_sorted(4 + (h-1)*5) - t) ...
                && sorted_tn(i,2) <= (staves_sorted(4 + (h-1)*5) + t))
            disp('g_l')
            play_back = [play_back; 5];
            play_back_actual = [play_back_actual; 'g_3'];
        end
        if (sorted_tn(i,2) >= (staves_sorted(4 + (h-1)*5) - 0.5*diff - t) ...
                && sorted_tn(i,2) <= (staves_sorted(4 + (h-1)*5) - 0.5*diff + t))
            disp('a_l')
            play_back = [play_back; 6];
            play_back_actual = [play_back_actual; 'a_3'];
        end
        if (sorted_tn(i,2) >= (staves_sorted(3 + (h-1)*5) - t) ...
                && sorted_tn(i,2) <= (staves_sorted(3 + (h-1)*5) + t))
            disp('b_l')
            play_back = [play_back; 7];
            play_back_actual = [play_back_actual; 'b_3'];
        end
        if (sorted_tn(i,2) >= (staves_sorted(3 + (h-1)*5) - 0.5*diff - t) ...
                && sorted_tn(i,2) <= (staves_sorted(3 + (h-1)*5) - 0.5*diff + t))
            disp('c_h')
            play_back = [play_back; 8];
            play_back_actual = [play_back_actual; 'c_4'];
        end
        if (sorted_tn(i,2) >= (staves_sorted(2 + (h-1)*5) - t) ...
                && sorted_tn(i,2) <= (staves_sorted(2 + (h-1)*5) + t))
            disp('d_h')
            play_back = [play_back; 9];
            play_back_actual = [play_back_actual; 'd_4'];
        end
        if (sorted_tn(i,2) >= (staves_sorted(2 + (h-1)*5) - 0.5*diff - t) ...
                && sorted_tn(i,2) <= (staves_sorted(2 + (h-1)*5) - 0.5*diff + t))
            disp('e_h')
            play_back = [play_back; 10];
            play_back_actual = [play_back_actual; 'e_4'];
        end
        if (sorted_tn(i,2) >= (staves_sorted(1 + (h-1)*5) - t) ...
                && sorted_tn(i,2) <= (staves_sorted(1 + (h-1)*5) + t))
            disp('f_h')
            play_back = [play_back; 11];
            play_back_actual = [play_back_actual; 'f_4'];
        end
        if (sorted_tn(i,2) >= (staves_sorted(1 + (h-1)*5) - 0.5*diff - t) ...
                && sorted_tn(i,2) <= (staves_sorted(1 + (h-1)*5) - 0.5*diff + t))
            disp('g_h')
            play_back = [play_back; 12];
            play_back_actual = [play_back_actual; 'g_4'];
        end
        
    end
end
end

function [play_back, play_back_actual] = get_notes_bass(staves_sorted, sorted_tcleft, sorted_tn, diff, t)
play_back = [];
play_back_actual = [];
for h=1:size(sorted_tcleft, 1)
    for i=1:length(sorted_tn)
        
        if (sorted_tn(i,2) >= (staves_sorted(10 + (h-1)*5) + 1*diff - t)...
                && sorted_tn(i,2) <= (staves_sorted(10 + (h-1)*5) + 1*diff + t))
            disp('e_l')
            play_back = [play_back; 21];
            play_back_actual = [play_back_actual; 'e_2'];
        end
        if (sorted_tn(i,2) >= (staves_sorted(10 + (h-1)*5) + 0.5*diff - t) ...
                && sorted_tn(i,2) <= (staves_sorted(10 + (h-1)*5) + 0.5*diff + t))
            disp('f_l')
            play_back = [play_back; 22];
            play_back_actual = [play_back_actual; 'f_2'];
        end
        if (sorted_tn(i,2) >= (staves_sorted(10 + (h-1)*5) - t) &&...
                sorted_tn(i,2) <= (staves_sorted(10 + (h-1)*5) + t))
            disp('g_l')
            play_back = [play_back; 23];
            play_back_actual = [play_back_actual; 'g_2'];
        end
        if (sorted_tn(i,2) >= (staves_sorted(10 + (h-1)*5) - 0.5*diff - t) &&...
                sorted_tn(i,2) <= (staves_sorted(10 + (h-1)*5) - 0.5*diff + t))
            disp('a_l')
            play_back = [play_back; 24];
            play_back_actual = [play_back_actual; 'a_2'];
        end
        if (sorted_tn(i,2) >= (staves_sorted(9 + (h-1)*5) - t) ...
                && sorted_tn(i,2) <= (staves_sorted(9 + (h-1)*5) + t))
            disp('b_l')
            play_back = [play_back; 25];
            play_back_actual = [play_back_actual; 'b_2'];
        end
        if (sorted_tn(i,2) >= (staves_sorted(9 + (h-1)*5) - 0.5*diff - t) ...
                && sorted_tn(i,2) <= (staves_sorted(9 + (h-1)*5) - 0.5*diff + t))
            disp('c_l')
            play_back = [play_back; 26];
            play_back_actual = [play_back_actual; 'c_2'];
        end
        if (sorted_tn(i,2) >= (staves_sorted(8 + (h-1)*5) - t) ...
                && sorted_tn(i,2) <= (staves_sorted(8 + (h-1)*5) + t))
            disp('d_l')
            play_back = [play_back; 27];
            play_back_actual = [play_back_actual; 'd_2'];
        end
        if (sorted_tn(i,2) >= (staves_sorted(8 + (h-1)*5) - 0.5*diff - t) ...
                && sorted_tn(i,2) <= (staves_sorted(8 + (h-1)*5) - 0.5*diff + t))
            disp('e_h')
            play_back = [play_back; 28];
            play_back_actual = [play_back_actual; 'e_2'];
        end
        if (sorted_tn(i,2) >= (staves_sorted(7 + (h-1)*5) - t) ...
                && sorted_tn(i,2) <= (staves_sorted(7 + (h-1)*5) + t))
            disp('f_h')
            play_back = [play_back; 29];
            play_back_actual = [play_back_actual; 'f_2'];
        end
        if (sorted_tn(i,2) >= (staves_sorted(7 + (h-1)*5) - 0.5*diff - t) ...
                && sorted_tn(i,2) <= (staves_sorted(7 + (h-1)*5) - 0.5*diff + t))
            disp('g_h')
            play_back = [play_back; 30];
            play_back_actual = [play_back_actual; 'g_2'];
        end
        if (sorted_tn(i,2) >= (staves_sorted(6 + (h-1)*5) - t) ...
                && sorted_tn(i,2) <= (staves_sorted(6 + (h-1)*5) + t))
            disp('a_h')
            play_back = [play_back; 31];
            play_back_actual = [play_back_actual; 'a_2'];
        end
        if (sorted_tn(i,2) >= (staves_sorted(6 + (h-1)*5) - 0.5*diff - t) ...
                && sorted_tn(i,2) <= (staves_sorted(6 + (h-1)*5) - 0.5*diff + t))
            disp('b_h')
            play_back = [play_back; 32];
            play_back_actual = [play_back_actual; 'b_2'];
        end
        if (sorted_tn(i,2) >= (staves_sorted(6 + (h-1)*5) - 1*diff - t) ...
                && sorted_tn(i,2) <= (staves_sorted(6 + (h-1)*5) - 1*diff + t))
            disp('c_h')
            play_back = [play_back; 33];
            play_back_actual = [play_back_actual; 'c_3'];
        end
        
    end
end
end