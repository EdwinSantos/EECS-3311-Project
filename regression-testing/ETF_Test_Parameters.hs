module ETF_Test_Parameters where

data OperatingSystem = Linux | MacOSX

-- Should the regression testing proceeds with a list 
-- of expected files, or the oracle?
-- When this flag is set True, the the value of 'oracle' is ignored. 
is_expected = False

-- Specify where you put the oracle.
oracle = "../oracle.exe"

-- Set true if you want the comparison to be tolerant on white spaces and empty lines.
is_tolerant_on_white_spaces = True

-- Specify the path of the executable built from your project.  
executable :: OperatingSystem -> FilePath
--executable MacOSX = "./tracker.osx.exe"
-- executable MacOSX = "./osx"
-- /home/user/eecs3311/project/Project/tracker/EIFGENs/tracker/W_code/
-- ..tracker/EIFGENs/tracker/W_code/tracker
executable Linux  = "../tracker/EIFGENs/tracker/W_code/tracker"

-- Specify where you want to log the outputs 
-- from both the oracle and your executable.
-- In the case 'is_expected' is set to True, 
--   expected output files are copied from the directory 
-- containing 'acceptance_tests' into 'log_dir'
-- In the case 'is_expected' is set to False,
--   expected output files are generated using 'oracle' into 'log_dir'
log_dir = "./log"

-- Specify the list of (relative or absolute) paths of the acceptance test files.
 --   [ "../at1.txt", "../at2.txt" ]
acceptance_tests =  [ "../luca/at1.txt" ,"../luca/at2.txt" ,"../luca/at3.txt" ,"../luca/at4.txt" ,"../luca/at5.txt" ,"../luca/at6.txt" ,"../luca/at7.txt" ,"../luca/at8.txt" ,"../luca/at9.txt" ,"../luca/at10.txt" ,"../luca/at11.txt" ,"../luca/at12.txt" ,"../luca/at13.txt" ]
