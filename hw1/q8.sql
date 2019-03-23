SELECT teamRoadKills, AVG(teamPlace) AS avgWinPlacePerc 
FROM
  (
  SELECT SUM(player_statistic.roadKills) AS teamRoadKills, AVG(player_statistic.winPlacePerc) AS teamPlace
  FROM `player_statistic`
  INNER JOIN `match`
  ON player_statistic.matchId=match.matchId
  GROUP BY player_statistic.groupId
  ) teamInfo
GROUP BY teamRoadKills
ORDER BY avgWinPlacePerc DESC; 
