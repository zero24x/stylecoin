#include "maintests.h"

const CBlockIndex* pindexPrev;

void MainTests::testGetProofOfWorkReward()
{

	QCOMPARE(GetProofOfWorkReward(1, 2), (50000000 * COIN + 2));

	QCOMPARE(GetProofOfWorkReward(22315, 2), (8 * COIN + 2));

	QCOMPARE(GetProofOfWorkReward(224000, 2), (2 * COIN + 2));

}

void MainTests::testGetProofOfStakeReward()
{
	QCOMPARE(GetProofOfStakeReward(pindexPrev, 100, 1), (2 * COIN + 1));
}
