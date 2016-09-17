#!/bin/bash
set -e

# Set the defaults
DEFAULT_RES="1280x1024x24"
DEFAULT_DISPLAY=":99"
RES=${RES:-$DEFAULT_RES}
DISPLAY=${DISPLAY:-$DEFAULT_DISPLAY}
TEST_PATH=${TEST_PATH:-$TEST_PATH}
TEST_FILE=${TEST_FILE:-$TEST_FILE}

# Start Xvfb
echo -e "Starting Xvfb on display ${DISPLAY} with res ${RES}"
Xvfb ${DISPLAY} -ac -screen 0 ${RES} -nolisten tcp&
export DISPLAY=${DISPLAY}
sleep 4

if [ ! -z $TEST_PATH ] && [ ! -z $TEST_FILE ]; then
    echo -e "Executing robot tests on PATH/FILE ${TEST_PATH}/${TEST_FILE}"
    pybot ${TEST_PATH}/${TEST_FILE}
elif [ ! -z $TEST_FILE ]; then
    echo -e "Executing robot tests on FILE : ${TEST_FILE}"
    pybot ${TEST_FILE}
elif [ ! -z $TEST_PATH ]; then
    echo -e "Executing robot tests on FILE : ${TEST_PATH}"
    pybot --output output_${TEST_PATH}.xml --report report_${TEST_PATH}.html --log log_${TEST_PATH}.html ${TEST_PATH}
else
    echo -e "Executing robot tests on default path : /robots"
    pybot /robots
fi

# pybot --variable BROWSER:${BROWSER} ${ROBOT_TESTS}

# Stop Xvfb
kill -9 $(pgrep Xvfb)
