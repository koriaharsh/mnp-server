import sys

sys.path.append("..")
sys.path.append("./")

from fastapi import Request, WebSocket, APIRouter, WebSocketDisconnect
import numpy as np
import pandas as pd
import csv
import json
import os
import time
import threading


router = APIRouter(
    prefix="/stream",
    tags=["stream"],
    responses={401: {"user": "Not authorized"}}
)


@router.websocket("/eeg/analysis")
async def websocket_eeg_theta_beta_endpoint(websocket: WebSocket):
    await websocket.accept()
    sample = await websocket.receive_json()
    print(sample)
    data = sample['data']
    print(data)

    if len(buffer)<= 250:
        print("appending")
        buffer.append(data)

    if len(buffer) == 250:
        print("clearing")
        result = await psd(buffer)
        print(result)
        print("type of result  ", type(result))
        await websocket.send_json(json.dumps(result))
        buffer.clear()


def mean_freq(f, P):
    P = np.array([int(b) for b in P])
    psd_df = pd.DataFrame(np.concatenate([[f], [P]], axis=0)).T
    psd_df.columns = ["freq", "Pxx"]
    return psd_df[psd_df["Pxx"] != 0]["freq"].mean()

def butter_bandpass(lowcut, highcut, fs, order=5):
    nyq = 0.5 * fs
    low = lowcut / nyq
    high = highcut / nyq
    sos = butter(order, [low, high], analog=False, btype='band', output='sos')
    return sos

def butter_bandpass_filter(data, lowcut, highcut, fs, order=5):
    sos = butter_bandpass(lowcut, highcut, fs, order=order)
    y = sosfilt(sos, data)
    return y

async def psd(data_batch):
    raw = pd.DataFrame(data_batch)
    mean_raw = raw.mean(axis=1).values
    avg_raw = np.average(mean_raw)
    theta = butter_bandpass_filter(mean_raw, 4, 8, 250, order=2)
    alpha = butter_bandpass_filter(mean_raw, 8, 12, 250, order=2)
    beta = butter_bandpass_filter(mean_raw, 13, 30, 250, order=2)
    gamma = butter_bandpass_filter(mean_raw, 31, 45, 250, order=2)

    f_alpha, P_alpha = sgn.welch(alpha, 250, nperseg=1024)
    f_beta, P_beta = sgn.welch(beta, 250, nperseg=1024)
    f_theta, P_theta = sgn.welch(theta, 250, nperseg=1024)
    f_gamma, P_gamma = sgn.welch(gamma, 250, nperseg=1024)

    st = StandardScaler()

    P_alpha = np.abs(st.fit_transform(P_alpha.reshape(-1, 1)))
    P_alpha = np.ravel(P_alpha)

    P_beta = np.abs(st.fit_transform(P_beta.reshape(-1, 1)))
    P_beta = np.ravel(P_beta)

    P_theta = np.abs(st.fit_transform(P_theta.reshape(-1, 1)))
    P_theta = np.ravel(P_theta)

    P_gamma = np.abs(st.fit_transform(P_gamma.reshape(-1, 1)))
    P_gamma = np.ravel(P_gamma)

    meanf_a = mean_freq(f_alpha, P_alpha)
    meanf_b = mean_freq(f_beta, P_beta)
    meanf_c = mean_freq(f_theta, P_theta)
    meanf_g = mean_freq(f_gamma, P_gamma)

    # return [np.average(P_alpha), np.average(P_beta), np.average(P_theta)], [meanf_a, meanf_b, meanf_c], \
    #        {"meditation score": np.average(P_alpha) / np.average(P_theta),
    #         "attention score": np.average(P_beta) / np.average(P_theta), "normalized_alpha": alpha,
    #         "normalized_beta": beta, \
    #         "normalized_alpha": theta}

    return {
        "alphaAvg": np.average(P_alpha),
        "betaAvg": np.average(P_beta),
        "thetaAvg": np.average(P_theta),
        "gammaAvg": np.average(P_gamma),
        "meanA": meanf_a,
        "meanB": meanf_b,
        "meanC": meanf_c,
        "meanG": meanf_g,
        "meanRaw": avg_raw,
        "meditationScore": np.average(P_alpha) / np.average(P_theta),
        "attentionScore": np.average(P_beta) / np.average(P_theta)
    }


@router.websocket("/cv_landmarks")
async def write_cv_landmarks_to_csv(websocket: WebSocket):
    await websocket.accept()
    # check_new_csv()
    try:
        sample = await websocket.receive_json()
        with open(r"\\DESKTOP-HEQFNBO\Users\hp\Documents\CDAC\mnp1336_v1\mnp_modality2_Strees_relax\Device_Data_Genrated\CV\S01\sub01_CV.csv", mode='a+', newline='') as file:
            writer = csv.writer(file)
            cv_lm = []
            for i in range (68):
                # print(sample['landmarks'][i]['_x'], sample['landmarks'][i]['_y'])
                cv_lm.append(sample['landmarks'][i]['_x'])
                cv_lm.append(sample['landmarks'][i]['_y'])
            cv_lm.append(sample['timestamp'])
            # print(cv_lm)
            writer.writerow(cv_lm)
    except WebSocketDisconnect:
        await websocket.close()
        return


def check_new_csv():
    directory = r"\\DESKTOP-HEQFNBO\Users\hp\Documents\CDAC\mnp1336_v1\Testing_Phase_1\CV_Phase1\Data_Test_CV"
    previous_files = set(os.listdir(directory))
    while True:
        time.sleep(10) # wait for 10 seconds
        current_files = set(os.listdir(directory))
        new_files = current_files - previous_files
        for new_file in new_files:
            if new_file.endswith('.csv'):
                print(f"New CSV file added: {new_file}")
                return f"New CSV file added: {new_file}"
        previous_files = current_files


READ_PATH = r"\\DESKTOP-HEQFNBO\Users\hp\Documents\CDAC\mnp1336_v1\Testing_Phase_1\CV_Phase1\Output_model\Logestic_Regression.csv"
@router.websocket("/accuracy")
async def read_accuracy_from_csv(websocket: WebSocket):
    await websocket.accept()


@router.websocket("/record_eeg")
async def record_eeg_data(websocket: WebSocket):
    await websocket.accept()
    try:
        sample = await websocket.receive_json()
        with open(r"\\DESKTOP-HEQFNBO\Users\hp\Documents\CDAC\mnp1336_v1\mnp_modality2_Strees_relax\Device_Data_Genrated\EEG\S01", "a+",newline='') as file:
            writer = csv.writer(file)
            writer.writerow(sample['data'])
            print(sample['data'])
    except WebSocketDisconnect:
        await websocket.close()


@router.post("/dump_eeg")
async def dump_eeg_in_csv(request: Request):
    sample = await request.json()
    with open(r"\\DESKTOP-HEQFNBO\Users\hp\Documents\CDAC\mnp1336_v1\mnp_modality2_Strees_relax\Device_Data_Genrated\EEG\S01\sub01_EEG.csv","a+", newline='') as file:
        writer = csv.writer(file)
        for i in range (len(sample['c1'])):
            writer.writerow([sample['c1'][i], sample['c2'][i], sample['c3'][i], sample['c4'][i], sample['c5'][i], sample['c6'][i], sample['c7'][i], sample['c8'][i], sample['ts'][i]])

    # print(sample['c1'])
    return "EEG Dumped Successfully"

