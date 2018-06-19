import * as React from 'react';
import { Button, Col, FormGroup, Input, InputGroup, InputGroupAddon, Row } from 'reactstrap';
interface Props {
    onSearch: (crn: string) => void;
}

interface State {
    searchTerm: string;
}

class SearchBar extends React.Component<Props, State> {
    /**
     * Render a search bar that manages its current searchTerm and submits
     * that term to the API through an action function passed in.
     * @param props The action function to handle the database query
     */
    constructor(props: Props) {
        super(props);
        this.state = { searchTerm: '' };
    }

    onSearch = (event: any) => {
        event.preventDefault();
        this.props.onSearch(this.state.searchTerm);
    };

    updateSearchTerm = (event: any) => {
        this.setState({
            searchTerm: event.target.value,
        });
    };

    render() {
        return (
            <Row className="justify-content-center my-5">
                <Col md="8">
                    <form onSubmit={this.onSearch}>
                        <FormGroup>
                            <InputGroup>
                                <Input
                                    type="search"
                                    name="search"
                                    id="exampleSearch"
                                    placeholder="Enter CRN..."
                                    value={this.state.searchTerm}
                                    onChange={this.updateSearchTerm}
                                    className="shadow mb-3 bg-white"
                                />
                                <InputGroupAddon addonType="append">
                                    <Button className="shadow-sm mb-3 bg-white">
                                        <i className="fas fa-search" />
                                    </Button>
                                </InputGroupAddon>
                            </InputGroup>
                        </FormGroup>
                    </form>
                </Col>
            </Row>
        );
    }
}

export default SearchBar;
