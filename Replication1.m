% Number of rounds
rounds = 7;
% Number of buyers
num_buyers = 3;
% Define valuations of the buyers
valuations = [12, 9, 4]; 

% Initialize storage for results
bids_history = zeros(rounds, num_buyers);
profits = zeros(rounds, num_buyers);
social_welfare = zeros(rounds, 1);

% Simulate the auction for 7 rounds
for r = 1:rounds
    % Generate random bids for each buyer
    bids = [randi([1, 12]), randi([1, 9]), randi([1, 4])];
    bids_history(r, :) = bids;
    
    % Sort bids in descending order to determine winners
    [sorted_bids, indices] = sort(bids, 'descend');
    
    % Two highest bidders win the item
    winner1 = indices(1);
    winner2 = indices(2);
    
    % The third-highest bid is the price
    price = sorted_bids(3);
    
    % Compute profits for each buyer
    for i = 1:num_buyers
        if i == winner1 || i == winner2
            profits(r, i) = valuations(i) - price;
        else
            profits(r, i) = 0;
        end
    end
    
    % Calculate social welfare (sum of valuations of winners)
    social_welfare(r) = valuations(winner1) + valuations(winner2);
    
    % Display results for the round
    fprintf('Round %d: Bids = [%d, %d, %d], Winners = [%d, %d], Price = %d\n', ...
        r, bids(1), bids(2), bids(3), winner1, winner2, price);
    fprintf('Profits: [%d, %d, %d]\n\n', profits(r, 1), profits(r, 2), profits(r, 3));
end

% Calculate total profits and overall social welfare
total_profits = sum(profits, 1);
overall_social_welfare = sum(social_welfare);

% Display final results
fprintf('Total Profits: [%d, %d, %d]\n', total_profits(1), total_profits(2), total_profits(3));
fprintf('Overall Social Welfare: %d\n', overall_social_welfare);
