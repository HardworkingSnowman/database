SELECT Id, AVG(kills) AS avgKills 
FROM `player_statistic` 
WHERE Id IN 
  (
  SELECT player_statistic.Id 
  FROM `player_statistic`, `match`
  WHERE match.numGroup<=10 AND match.matchId=player_statistic.matchId
  ) 
GROUP BY Id
ORDER BY avgKills
DESC LIMIT 20;
