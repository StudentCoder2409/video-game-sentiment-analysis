-- =========================================
-- Video Game Sentiment Analysis Project
-- Author: Ignacio
-- =========================================
-- Query 1: Best selling games
SELECT *
FROM game_sales AS best_selling_games
ORDER BY games_sold DESC
LIMIT 10;

-- =========================================
-- Query 2: Critics Top Ten Years
-- Description: Finds years with highest average critic scores
-- =========================================
SELECT 
    g.year,
    COUNT(*) AS num_games,
    ROUND(AVG(r.critic_score), 2) AS avg_critic_score
FROM public.game_sales g
JOIN public.reviews r
    ON g.name = r.name
GROUP BY g.year
HAVING COUNT(*) >= 4
ORDER BY avg_critic_score DESC
LIMIT 10;


-- =========================================
-- Query 3: Golden Years
-- Description: Compares critic vs user ratings by year
-- =========================================
SELECT 
    user_rating.year,
    user_rating.num_games,
    critic_rating.avg_critic_score,
    user_rating.avg_user_score,
    (critic_rating.avg_critic_score - user_rating.avg_user_score) AS diff
FROM users_avg_year_rating user_rating
JOIN critics_avg_year_rating critic_rating
    ON user_rating.year = critic_rating.year
WHERE user_rating.avg_user_score > 9
   OR critic_rating.avg_critic_score > 9
ORDER BY user_rating.year ASC;
