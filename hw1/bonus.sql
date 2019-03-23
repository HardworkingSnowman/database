SELECT player_statistic.Id, SUM((player_statistic.boosts+player_statistic.heals+player_statistic.revives)/match.matchDuration)/COUNT(match.matchId) AS saint_point 
FROM `player_statistic`
INNER JOIN `match`
ON match.matchId=player_statistic.matchId
GROUP BY player_statistic.Id 
ORDER BY saint_point DESC
LIMIT 10;
