# Author: Karin Pestke,
#         DOHMATOB Elvis

import glob
import numpy as np
import pylab as pl
import h5py
from sklearn.externals.joblib import Memory


def loadmat():
    # subject .mat files
    subject_mats = sorted(
        glob.glob("/home/elvis/*subj_matrix.mat"))

    # get length of shortest run for a subject
    min_l = np.inf
    n_subjects = 0
    for subject_mat in subject_mats:
        try:
            f = h5py.File(subject_mat)
            n_runs = f['subj_matrix'].shape[0]
            l = np.min(
                [f[f['subj_matrix'][run, 0]]["MatrixQ"].shape[0]
                 for run in xrange(n_runs)])
            if l < min_l:
                min_l = l
            n_subjects += 1
        except ValueError:
            continue

    # main loop
    space_ = np.ndarray((n_subjects, min_l))
    time_ = np.ndarray((n_subjects, min_l))
    spacespace_ = np.ndarray((n_subjects, min_l))
    spacetime_ = np.ndarray((n_subjects, min_l))
    timespace_ = np.ndarray((n_subjects, min_l))
    timetime_ = np.ndarray((n_subjects, min_l))
    i = 0  # subject counter
    for subject_mat in subject_mats:
        try:
            f = h5py.File(subject_mat)
            n_runs = f['subj_matrix'].shape[0]
            space = np.ndarray((n_runs, min_l))
            time = np.ndarray((n_runs, min_l))
            spacespace = np.ndarray((n_runs, min_l))
            spacetime = np.ndarray((n_runs, min_l))
            timespace = np.ndarray((n_runs, min_l))
            timetime = np.ndarray((n_runs, min_l))
            for run in xrange(n_runs):
                matrix = np.array(f[f['subj_matrix'][run, 0]]['matrix'])
                baselinedq = np.array(
                    f[f['subj_matrix'][run, 0]]['BaselinedQ'])
                space[run] = np.nanmean(
                    baselinedq[:min_l, matrix[3, :] == 1], axis=1)
                time[run] = np.nanmean(
                    baselinedq[:min_l, matrix[3, :] == 2], axis=1)

                spacespace[run] = np.nanmean(
                    baselinedq[:min_l, matrix[4, :] == 1], axis=1)
                spacetime[run] = np.nanmean(
                    baselinedq[:min_l, matrix[4, :] == 2], axis=1)
                timespace[run] = np.nanmean(
                    baselinedq[:min_l, matrix[4, :] == 3], axis=1)
                timetime[run] = np.nanmean(
                    baselinedq[:min_l, matrix[3, :] == 4], axis=1)
            space_[i] = np.nanmean(space, axis=0)
            time_[i] = np.nanmean(time, axis=0)
            spacespace_[i] = np.nanmean(spacespace, axis=0)
            spacetime_[i] = np.nanmean(spacetime, axis=0)
            timespace_[i] = np.nanmean(timespace, axis=0)
            timetime_[i] = np.nanmean(timetime, axis=0)
            i += 1
        except ValueError, e:
            print subject_mat, e
            continue

    return space_, time_, spacespace_, spacetime_, timespace_, timetime_

space_, time_, spacespace_, spacetime_, timespace_, timetime_ = Memory(
    "cache").cache(loadmat)()

# visualization
import matplotlib.pyplot as plt
fig1 = plt.figure(figsize=(13.5, 7))
fig2 = plt.figure(figsize=(13.5, 7))
for i in xrange(space_.shape[0]):
    plt.figure(fig1.number)
    plt.subplot(4, 3, i + 1)
    plt.plot(space_[i], linewidth=2, label="SpaceDim")
    plt.plot(time_[i], linewidth=2, label="TimeeDim",)
    plt.ticklabel_format(style='sci', axis='x', scilimits=(0, 0))

    plt.figure(fig2.number)
    plt.subplot(4, 3, i + 1)
    plt.plot(spacespace_[i], linewidth=2, label="SpaceSpaceDim")
    plt.plot(spacetime_[i], linewidth=2, label="SpaceTimeDim")
    plt.plot(timespace_[i], linewidth=2, label="TimeSpaceDim")
    plt.plot(timetime_[i], linewidth=2, label="TimeTimeDim")
    plt.ticklabel_format(style='sci', axis='x', scilimits=(0, 0))

plt.figure(fig1.number)
plt.subplot2grid((4, 3), (3, 0), colspan=3)
plt.plot(np.nanmean(space_, axis=0), label="SpaceDim",
        linewidth=4)
plt.plot(np.nanmean(time_, axis=0), label="TimeDim",
        linewidth=4)
plt.legend(loc="best", prop=dict(size=15))
plt.xlim(500.)


plt.figure(fig2.number)
plt.subplot2grid((4, 3), (3, 0), colspan=3)
plt.plot(np.nanmean(spacespace_, axis=0), label="SpaceSpaceDim",
        linewidth=4)
plt.plot(np.nanmean(spacetime_, axis=0), label="SpaceTimeDim",
        linewidth=4)
plt.plot(np.nanmean(timespace_, axis=0), label="TimeSpaceDim",
        linewidth=4)
plt.plot(np.nanmean(timetime_, axis=0), label="TimeTimeDim",
        linewidth=4)
plt.legend(loc="best", prop=dict(size=15), ncol=2)
plt.xlim(500.)

# plt.xlabel("Time (milliseconds)", fontsize=25)
# plt.ylabel("Pupil size (arbitrary units)", fontsize=25)
# plt.tick_params(axis='both', which='major', labelsize=20)
plt.ticklabel_format(style='sci', axis='x', scilimits=(0, 0))
plt.show()


# for subject_data in matrices:
#     r = [run_data.MatrixQ[:, :3269] for run_data in subject_data if run_data]
#     mean = np.nanmean(r, axis=0)
