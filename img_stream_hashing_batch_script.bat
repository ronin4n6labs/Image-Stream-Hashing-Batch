@echo off
REM Script: img_stream_hashing_batch_script.bat
REM
REM Description:
REM This script processes image files in the same directory and generates streamhash for each image using ffmpeg.
REM The files extensions this script processes include .bmp, .gif, .jpg, .png, and .tif.
REM The resulting streamhash files are saved with the format 'filename_streamhash.txt.'
REM In addition, the script creates a streamhash_log.txt file for each file it processes.
REM
REM Usage:
REM Place this script in the directory containing the image files you want to process, then run the script.
REM
REM Script authored by Gregory S. Wales, DFS
REM For more information or collaboration opportunities, visit: https://github.com/ronin4n6labs
REM
REM References:
REM 1. Wales GS, Smith JM, Lacey DS, Grigoras C. "Multimedia stream hashing: A forensic method for content verification." J Forensic Sci. 2023;68:289–300. https://doi.org/10.1111/1556-4029.15148
REM 2. Wales GS. "Validation of image stream hashing: A forensic method for content verification." J Forensic Sci. 2023;00:1–14. https://doi.org/10.1111/1556-4029.15432
REM
REM Licensing:
REM This script is licensed under the MIT License. For more information, see the LICENSE file or visit: https://opensource.org/licenses/MIT
REM
REM ###############################################################

REM Get the path to the folder containing the script
set "script_folder=%~dp0"

REM Print message indicating the start of the stream hashing process
echo Stream hashing process started...

REM Open log file for writing
set "log_file=%script_folder%streamhash_log.txt"
(
    REM Iterate through files in the folder
    for %%F in (%script_folder%*.bmp %script_folder%*.gif %script_folder%*.jpg %script_folder%*.png %script_folder%*.tif) do (
        echo Processing file: %%~nxF
        ffmpeg -i "%%~fF" -f streamhash - > "%script_folder%%%~nF_streamhash.txt"
        REM Write filename and extension to log file
        echo %%~nxF>>"%log_file%"
    )
)

REM Print message indicating the completion of the stream hashing process
echo All stream hashing processes have completed.
