SELECT teamRoadKills, AVG(teamPlace) AS avgWinPlacePerc 
FROM
  (
  SELECT SUM(player_statistic.roadKills) AS teamRoadKills, AVG(player_statistic.winPlacePerc) AS teamPlace
  FROM `player_statistic`, `match`
  WHERE player_statistic.matchId=match.matchId AND (match.matchType='squad' OR match.matchType='squad-fpp')
  GROUP BY player_statistic.groupId
  ) teamInfo
GROUP BY teamRoadKills
ORDER BY teamRoadKills DESC; 
