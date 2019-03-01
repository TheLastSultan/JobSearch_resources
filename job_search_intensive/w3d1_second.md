# W3D1

## CoderPad-Style Interview
Solve this problem in your code editor

## Partner B Interviews Partner A

### Bowling Score (50 mins)
Write a method that calculates the score to a bowling game.  Input:  Array of arrays representing each roll score for each frame:

```
frames = [[1, '/'], ['x', '-'], ['x', '-'], ['x', '-'], [7, 1], [2, '/'], [8, '-'], ['x', '-'], [3, '-'], ['x', 3, '/']]
  => [20, 50, 77, 95, 103, 121, 129, 142, 145, 165]

# frames = [[1, '/'], ['x', '-'], ['x', '-'], ['x', '-'], [7, 1], [2, '/'], [8, '-'], ['x', '-'], ['x', '-'], ['x', 'x', 'x']]
  => [20, 50, 77, 95, 103, 121, 129, 159, 189, 219]
```

In bowling, the value of the current frame sometimes depends on the next balls rolled:
* If the current frame has a 'spare', the current frame is worth 10 plus the value of the next rolled ball.
* If the current frame has a 'strike', it is worth 10 plus the next two rolled balls.

In the tenth frame the bowler has a chance to roll three balls (as long as at least ten pins are cleared with the first two). Thus, a 'strike-spare' or a 'spare-strike' in the tenth is worth twenty points for that frame; three strikes in the tenth give 30 points.    

Have fun grappling with all the conditional statements!!! `XD`

### Solution

```ruby
frames = [[1, '/'], ['x', '-'], ['x', '-'], ['x', '-'], [7, 1], [2, '/'], [8, '-'], ['x', '-'], [3, '-'], ['x', 3, '/']]
# [20, 50, 77, 95, 103, 121, 129, 142, 145, 165]

# frames = [[1, '/'], ['x', '-'], ['x', '-'], ['x', '-'], [7, 1], [2, '/'], [8, '-'], ['x', '-'], ['x', '-'], ['x', 'x', 'x']]
# [20, 50, 77, 95, 103, 121, 129, 159, 189, 219]


def bowling_score(input_frames)

  # Change missed frames to zeros, to avoid dealing with strings all the time
  frames = input_frames.map do |frame|
    frame.map { |ball| ball == '-' ? 0 : ball }
  end

  scored_frames = Array.new(frames.length, 0)

  frames.each_with_index do |frame, i|
    scored_frames[i] = scored_frames[i-1] unless i == 0

    # if it's the last frame, we need to do things differently
    if i == 9
      # mutates input, so no reassignment necessary
      last_frame(frame, scored_frames)

    # If this isn't the last frame
    else
      # If this frame is a strike
      if frame[0] == 'x'
        # add 10 to this frame
        scored_frames[i] += 10
        # then if the next frame starts with a strike add 10 more
        if frames[i+1][0] == 'x'
          scored_frames[i] += 10
          # if it's the second to last frame,
          # you have to check the second ball of the last frame
          if i == 8
            # if the second ball of the last frame is a strike, add ten to frame 9
            if frames[i+1][1] == 'x'
              scored_frames[i] += 10
            else
              # otherwise just add the value of the second ball
              scored_frames[i] += frames[i+1][1]
            end
          # if it's not the 9th frame, and the next frame is a strike,
          # you look two frames ahead and add the first ball to this frame
          elsif frames[i+2][0] == 'x'
            scored_frames[i] += 10
          else
            scored_frames[i] += frames[i+2][0]
          end
        # if this frame is a strike and the next frame ends in a spare, add 10
        elsif frames[i+1][1] == '/'
          scored_frames[i] += 10
        # otherwise add the next two balls to this frame
        else
          scored_frames[i] += frames[i+1][0]
          scored_frames[i] += frames[i+1][1]
        end
      # if this frame has a spare, add 10 plus the value of the next ball
      elsif frame[1] == '/'
        scored_frames[i] += 10
        if frames[i+1][0] == 'x'
          scored_frames[i] += 10
        else
          scored_frames[i] += frames[i+1][0]
        end
      # otherwise just add these two balls to the score!
      else
        scored_frames[i] += frame[0]
        scored_frames[i] += frame[1]
      end
    end
    p scored_frames
  end
  p scored_frames
end

def last_frame(frame, scored_frames)
  # if the second ball is a spare, we count 10
  # plus the value of the third ball
  if frame[1] == '/'
    scored_frames[9] += 10
    scored_frames[9] += (frame[2] == 'x' ? 10 : frame[2]) unless frame[2] == '-'
  # if the last frame starts with a strike
  elsif frame[0] == 'x'
    # add 10
    scored_frames[9] += 10
    # if the second ball is a strike, add 10
    if frame[1] == 'x'
      scored_frames[9] += 10
      # if the third ball is a strike, add 10
      if frame [2] == 'x'
        scored_frames[9] += 10
      # otherwise add the value of the third ball
      else
        scored_frames[9] += frame[2]
      end
    # otherwise add the values of the last two balls
    else
      # the third ball could be a spare
      if frame[2] == '/'
        scored_frames[9] += 10
      else
        scored_frames[9] += frame[1]
        scored_frames[9] += frame[2]
      end
    end
  # otherwise the last frame is just the first two balls
  else
    scored_frames[9] += frame[0]
    scored_frames[9] += frame[1]
  end

end

bowling_score(frames)
```
