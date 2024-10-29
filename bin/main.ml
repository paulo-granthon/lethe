(* OCaml script to rename all files in a directory to random names and update their timestamps *)

(* Initialize the random seed *)
let () = Random.self_init ()

(* Function to generate a random string of given length *)
let random_string len =
  let chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789" in
  let chars_len = String.length chars in
  let result = Bytes.create len in
  for i = 0 to len - 1 do
    Bytes.set result i chars.[Random.int chars_len]
  done;
  Bytes.to_string result

(* Function to generate a unique random name in the specified directory *)
let unique_random_name dir extension =
  let rec generate () =
    let name = random_string 10 ^ extension in
    let path = Filename.concat dir name in
    if Sys.file_exists path then
      generate ()  (* Regenerate if name exists *)
    else
      name
  in
  generate ()

(* Function to read the contents of a file *)
let read_file_contents path =
  let ic = open_in path in
  let content = really_input_string ic (in_channel_length ic) in
  close_in ic;
  content

(* Function to write contents to a file *)
let write_file_contents path content =
  let oc = open_out path in
  output_string oc content;
  close_out oc

(* Function to rename all files in a directory to a random name *)
let rename_files_in_directory dir =
  let files = Array.to_list (Sys.readdir dir) in
  List.iter (fun file ->
    let old_path = Filename.concat dir file in
    if not (Sys.is_directory old_path) then
      let extension = Filename.extension file in
      let new_name = unique_random_name dir extension in
      let new_path = Filename.concat dir new_name in

      (* Read the contents of the original file *)
      let content = read_file_contents old_path in
      
      (* Delete the original file *)
      Sys.remove old_path;

      (* Create a new file with the random name and write the contents back *)
      write_file_contents new_path content;

      (* Change access and modification times to the current time *)
      let current_time = Unix.gettimeofday () in
      Unix.utimes new_path current_time current_time
  ) files

(* Main function *)
let () =
  let dir = Sys.argv.(1) in
  if Sys.is_directory dir then
    rename_files_in_directory dir
  else
    Printf.printf "Error: %s is not a valid directory\n" dir

