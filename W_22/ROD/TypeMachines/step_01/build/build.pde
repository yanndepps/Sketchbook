/*
 * TypeMachines -> step_01
 * chars & strings, displaying text
 * In Processing there are two different variable types that can contain text:
 * Chars and Strings. A char is a single letter and a String is text of any length.
 * In 95% of all cases, using a String makes the most sense.
 * There are two very small syntactical differences between char and String:
 * When using char, the variable type is written in lowercase and single quotation marks are used.
 * For a String, the S must be capitalized and double quotes are always used.
 * char c = 'a';
 * String text = "Hi Internet!";
 *
 * To display text in Processing, there is the text()-function.
 * This function takes at least three parameters:
 * 1. the text to be displayed
 * 2. the x-position (float)
 * 3. the y-position (float)
 * Basically, you can pass almost any variable type as the first parameter to the Text function.
 * It then simply displays the value of the variable.
 */

String text = "Hi!";
char c = '?';

void setup() {
  size(620, 620);
  background(255);
  fill(0);
  // text(text, width/2, height/2);
  text(c, width/2, height/2);
}
