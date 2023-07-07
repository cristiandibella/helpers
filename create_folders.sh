#!/bin/bash

DATE=$(date +%d'_'%m'_'%Y)
DIRECTORY="$1"
NUM_DIRECTORIES="$2"

# Check if the necessary arguments were supplied
if [ -z "$DIRECTORY" ] || [ -z "$NUM_DIRECTORIES" ]; then
   echo "ERROR: You must supply the directory and the number of directories as arguments."
   exit 1
fi

# Check if the directory exists
if [ ! -d "$DIRECTORY" ]; then
   echo "ERROR: The directory $DIRECTORY does not exist."
   exit 1
fi

# Check if the number of directories is valid
if ! [[ "$NUM_DIRECTORIES" =~ ^[0-9]+$ ]]; then
   echo "ERROR: The number of directories must be a numeric value."
   exit 1
fi

for ((i = 0; i < NUM_DIRECTORIES; i++))
do
   NEXT_DATE=$(date -v +${i}d +%d-%m-%Y)
   FOLDER_PATH="$DIRECTORY/$NEXT_DATE"

   # Check if the directory already exists
   if [ -d "$FOLDER_PATH" ]; then
      echo "WARN: The $FOLDER_PATH directory already exists. Creation will be skipped."
      continue
   fi

   echo "INFO: Creating folder with name ${NEXT_DATE}"
   mkdir "$FOLDER_PATH"
   echo "INFO: Done!"
done