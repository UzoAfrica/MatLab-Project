% Define buyer valuations
valuations = [12, 9, 4]; % v1 = 12, v2 = 9, v3 = 4

% Define bid range (each buyer bids between 1 and their valuation)
b1_range = 1:12;
b2_range = 1:9;
b3_range = 1:4;

% Initialize storage for equilibria
equilibria = [];
social_welfare_list = [];

% Brute force search through all possible bid combinations
for b1 = b1_range
    for b2 = b2_range
        for b3 = b3_range
            % Store the current bid combination
            bids = [b1, b2, b3];
            
            % Sort bids in descending order to determine winners
            [sorted_bids, indices] = sort(bids, 'descend');
            
            % Two highest bidders win the item
            winner1 = indices(1);
            winner2 = indices(2);
            
            % The third-highest bid is the price
            price = sorted_bids(3);
            
            % Compute profits for each buyer
            profits = zeros(1, 3);
            for i = 1:3
                if i == winner1 || i == winner2
                    profits(i) = valuations(i) - price;
                else
                    profits(i) = 0;
                end
            end
            
            % Compute social welfare (sum of valuations of winners)
            social_welfare = valuations(winner1) + valuations(winner2);
            
            % Check if the bid is an equilibrium (no buyer can profit by deviating)
            is_equilibrium = true;
            for i = 1:3
                for new_bid = 1:valuations(i)
                    if new_bid ~= bids(i)
                        % Simulate the effect of changing the bid
                        new_bids = bids;
                        new_bids(i) = new_bid;
                        [new_sorted_bids, new_indices] = sort(new_bids, 'descend');
                        new_winner1 = new_indices(1);
                        new_winner2 = new_indices(2);
                        new_price = new_sorted_bids(3);
                        
                        % Compute new profit
                        new_profits = zeros(1, 3);
                        for j = 1:3
                            if j == new_winner1 || j == new_winner2
                                new_profits(j) = valuations(j) - new_price;
                            else
                                new_profits(j) = 0;
                            end
                        end
                        
                        % If the buyer improves their profit by deviating, it's not an equilibrium
                        if new_profits(i) > profits(i)
                            is_equilibrium = false;
                            break;
                        end
                    end
                end
                if ~is_equilibrium
                    break;
                end
            end
            
            % If equilibrium is found, store it
            if is_equilibrium
                equilibria = [equilibria; b1, b2, b3, social_welfare];
                social_welfare_list = [social_welfare_list, social_welfare];
            end
        end
    end
end

% Compute average social welfare for all equilibria
average_social_welfare_equilibria = mean(social_welfare_list);

% Display equilibria
fprintf('Buyer 1\tBuyer 2\tBuyer 3\tSocial Welfare\n');
for i = 1:size(equilibria, 1)
    fprintf('%d\t%d\t%d\t%d\n', equilibria(i, 1), equilibria(i, 2), equilibria(i, 3), equilibria(i, 4));
end

% Display average social welfare
fprintf('Average Social Welfare for All Equilibria: %.2f\n', average_social_welfare_equilibria);
